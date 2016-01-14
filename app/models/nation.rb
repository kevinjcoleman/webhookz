class Nation < ActiveRecord::Base
  attr_accessor :nation_token
  belongs_to :user

  # Returns the hash digest of the given string.
  def Nation.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def Nation.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def api_remember
    self.nation_token = Nation.new_token
    update_attribute(:api_key, Nation.digest(nation_token))
  end
end
