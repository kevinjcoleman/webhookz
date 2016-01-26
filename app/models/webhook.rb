class Webhook < ActiveRecord::Base
  belongs_to :nation
  before_create :decipher_event
  validates_uniqueness_of :event, :scope => :nation_id, :message => 'You already have a webhook for that event.'
  
  #Scopes
  scope :active, -> { where(active: true) }



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

  def decipher_event
  	self.event = WEBHOOK_HASH[event]
  end

  def normalized_event
  	return WEBHOOK_HASH.invert[self.event]
  end



end
