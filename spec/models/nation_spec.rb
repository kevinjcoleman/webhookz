require 'rails_helper'

describe Nation do
	before(:each) do
		@user = FactoryGirl.create(:user)
	end

	it "is valid with valid info" do
		valid_nation = FactoryGirl.create(:nation, user: @user)
		expect(valid_nation).to be_valid
	end

	it "is invalid with blank api key" do
		invalid_api_key = FactoryGirl.build(:nation, user: @user, api_key: "")
		expect(invalid_api_key).to_not be_valid
	end

	it "is invalid with short api key" do
		short_api_key = FactoryGirl.build(:nation, user: @user, api_key: "imtooshort")
		expect(short_api_key).to_not be_valid
	end
	it "is invalid with blank nation slug" do
		no_nation_slug = FactoryGirl.build(:nation, user: @user, nation_slug: "")
		expect(no_nation_slug).to_not be_valid
	end

	it "is invalid w/o a user" do
		no_user = FactoryGirl.build(:nation, user: nil)
		expect(no_user).to_not be_valid
	end

	it "api_valid is true if api_key is valid" do
		valid_api = FactoryGirl.create(:nation, user: @user)
		expect(valid_api.valid_api).to eq(true)
	end
	it "api_valid is false if api_key is invalid" do
		invalid_api = FactoryGirl.create(:nation, user: @user, api_key: "1af0f13fddf7f06c47be787fa6c909ed9782686ed763d63506b9b037bfd83887")
		expect(invalid_api.valid_api).to eq(false)
	end

	it "encrypts api_key" do
		@api_key = "78838dfb730b9b60536d367de6862879de909c6af787eb74c60f7fddf31f0fa1"
		encrypted_api = FactoryGirl.create(:nation, user: @user, api_key: @api_key)
		expect(encrypted_api.api_key).to_not eq(@api_key)
	end
end