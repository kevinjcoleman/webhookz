class Nation < ActiveRecord::Base
  attr_accessor :decrypted_api, :client
  before_create :api_encrypt
  before_save :validate_api
  belongs_to :user

  def api_encrypt
    API_ENCRYPTION.each do |key, value|
      while(self.api_key.include?(key))
        self.api_key.sub!(key, value)
      end
    end
    self.api_key = api_key.reverse.downcase
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
    @decrypted_api = decrypted_key.reverse
  end

  def update_webhooks_count
    self.webhooks_count = client.call(:webhooks, :index)["results"].count
  end

  def validate_api
    begin
      initialize_client
      update_webhooks_count
    rescue
      self.valid_api = false
    end
  end
end
