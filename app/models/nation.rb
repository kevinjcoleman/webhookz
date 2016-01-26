class Nation < ActiveRecord::Base
  attr_accessor :decrypted_api, :client
  before_create :api_encrypt
  #after_save :update_if_not_updated_recently
  #before_save :update_if_not_updated_recently, :on => :update
  belongs_to :user
  validates :user, presence: true
  validates :api_key, :presence => { :message => "You need an API Token to access NationBuilder's API." }, length: { minimum: 64, too_short: "Your token is too short." }
  validates :nation_slug, :presence => { :message => "You must have a nation slug to access NationBuilder's API." }
  has_many :webhooks
  validates_uniqueness_of :nation_slug, :scope => :user_id, :message => 'You already have a nation with that slug.'

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
    self.webhooks_count = webhooks.active.count
    self.updated_at = Time.now
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

  def update
    begin
      initialize_client
      webhooks = @client.call(:webhooks, :index)["results"]
      ids = []
      webhooks.each {|id| ids << id["id"]}
      binding.pry
      webhooks.each do |w|
        next if self.webhooks.active.find_by(external_id: w["id"])
        self.webhooks.create(event: WEBHOOK_HASH.invert[w["event"]], external_id: w["id"], link: w["url"])
      end
      inactive_webhooks = self.webhooks.active.where.not(external_id:  ids)
      inactive_webhooks.each {|d| d.update_attributes(active: false) }
      self.valid_api = true
      update_webhooks_count
      rescue
        self.valid_api = false
        return true
    end
    self.save
  end

  def updated_recently?
    if updated_at < 6.hours.ago
      true
    else
      false
    end
  end

  def update_if_not_updated_recently
    if self.updated_at.nil?
      update
    elsif self.updated_recently?
      update
    end
  end

  def webhook_create(webhook_params)
    @webhook = self.webhooks.create(event: webhook_params)
    initialize_client
    webhook = {
      webhook: {
        version: 4,
        url: "https://murmuring-tundra-2773.herokuapp.com/users/#{self.user.id}/nations/#{self.id}/webhook/#{ @webhook.id }/post",
        event: @webhook.event
      }
    }
    result = @client.call(:webhooks, :create, webhook)
    @webhook.update_attributes(external_id: result["webhook"]["id"], link: result["webhook"]["url"])
  end

  WEBHOOK_HASH = {
    "When a person is created." => "person_created", 
    "When a person is changed." => "person_changed", 
    "When a person is contacted." => "person_contacted", 
  "When a person is merged." => "person_merged",  
  "When a person is destroyed." => "person_destroyed",
  "When people are destroyed." => "people_destroyed",
    "When a person successfully donates." => "donation_succeeded", 
    "When a donation is changed." => "donation_changed", 
    "When a donation is canceled." => "donation_canceled"
  }

end
