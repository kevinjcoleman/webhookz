require 'faker'

FactoryGirl.define do
	factory :user do
	    email { Faker::Internet.email }
	    password { Faker::Internet.password }

	    trait :other_user do
		    email { Faker::Internet.email }
		    password { Faker::Internet.password }
		end
	end

  factory :nation do
    nation_slug 'mynation'
    api_key '78838dfb730b9b60536d367de6862879de909c6af787eb74c60f7fddf31f0fa1'
  end
end
