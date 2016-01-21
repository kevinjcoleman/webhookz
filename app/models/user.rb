class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :nations

  def load_nations
  	self.nations.each do |nation|
  		nation.update_if_not_updated_recently
  	end
  end
end
