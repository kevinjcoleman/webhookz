class Action < ActiveRecord::Base
  belongs_to :webhook
  enum action_type: [ :note ]
end
