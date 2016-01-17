class Nation < ActiveRecord::Base
  attr_accessor :decrypted_api, :client
  before_create :api_encrypt
  before_save :validate_api
  belongs_to :user
  validates :user, presence: true
  validates :api_key, presence: true, length: { minimum: 64, too_short: "%{count} characters is too short for a NationBuilder API Token." }
  validates :nation_slug, presence: true

  def api_encrypt
    API_ENCRYPTION.each do |key, value|
      while(self.api_key.include?(key))
        self.api_key.sub!(key, value)
      end
    end
    self.api_key = api_key.downcase
  end

  def initialize_client
    decrypt
    @client = NationBuilder::Client.new(nation_slug, decrypted_api)
  end

  def decrypt
    api_decrypt(self.api_key)
  end

  def api_decrypt(api_key)
    decrypted_key = api_key
    API_ENCRYPTION.each do |key, value|
      if decrypted_key.include?(value)
        decrypted_key = decrypted_key.gsub(value, key)
      end
    end
    @decrypted_api = decrypted_key
  end

  def update_webhooks_count
    self.webhooks_count = client.call(:webhooks, :index)["results"].count
  end

  def validate_api
    begin
      initialize_client
      if @client
        update_webhooks_count
        self.valid_api = true
      else
        self.valid_api = false
      end
    rescue
      self.valid_api = false
      return true
    end
  end

end
