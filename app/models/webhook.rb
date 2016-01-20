class Webhook < ActiveRecord::Base
  belongs_to :nation
  
  #Scopes
  scope :active, -> { where(active: true) }

end
