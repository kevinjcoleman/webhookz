require 'rails_helper'

describe User do
	it "has valid info" do
		valid_user = FactoryGirl.create(:user)
		expect(valid_user).to be_valid
	end
	it "is invalid with bad email" do
		invalid_email = FactoryGirl.build(:user, email: "kevincoleman@example")
		expect(invalid_email).to_not be_valid
	end

	it "is invalid with short password" do
		invalid_password = FactoryGirl.build(:user, password: "short")
		expect(invalid_password).to_not be_valid
	end
end