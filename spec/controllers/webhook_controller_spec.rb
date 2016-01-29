require 'rails_helper'

RSpec.describe WebhookController, :type => :controller do
	login_user
	
  describe "GET new" do
    it "returns http success" do
    	@nation = FactoryGirl.create(:nation, user: @user)
      get :new, user_id: @user.id, nation_id: @nation.id
      expect(response).to be_success
    end
  end
end
