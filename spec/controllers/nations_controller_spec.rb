require 'rails_helper'

describe NationsController do
	before(:each) do
		@user = FactoryGirl.create(:user)
		login_as(user, :scope => :user)
	end

	describe 'POST #create' do
	end

end
