require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	login_user
	
	describe "GET #show" do

		it 'redirects if accessing other users page' do
			@other_user = FactoryGirl.create(:user,:other_user)
			get :show, id: @other_user.id
			expect(response).to redirect_to(user_path(@user))
		end

		it 'doesn\'t redirect if accessing own page' do
			get :show, id: @user.id
			expect(response).to_not have_content("You can't access that page.") 
		end
	end
end