require 'rails_helper'

describe NationsController do
	login_user

	it 'redirects if not current user\'s nation' do
		@other_user = FactoryGirl.create(:user, :other_user)
		@other_user_nation = FactoryGirl.create(:nation, user: @other_user)
		get :show, user_id: @other_user.id, id: @other_user_nation.id
		expect(response).to redirect_to(user_path(@user))
	end

	describe 'GET #show' do
		it 'shows the current user\'s nation' do 
			@user_nation = FactoryGirl.create(:nation, user: @user)
			get :show, user_id: @user.id, id: @user_nation.id
			expect(response).to render_template("show")
		end
	end

	describe 'GET #new' do
		it 'goes to a form for creating a new nation.' do
			get :new, user_id: @user.id
			expect(response).to render_template("new")
		end
	end

	describe 'POST #create' do
		it 'creates a new nation'
	end

	describe 'GET #edit' do
		it 'goes to a form for editing a nation.' do 
			@user_nation = FactoryGirl.create(:nation, user: @user)
			get :edit, user_id: @user.id, id: @user_nation.id 
			expect(response).to render_template("edit")
		end
	end


	describe 'PATCH #update' do
		it 'updates an existing nation'
	end

end
