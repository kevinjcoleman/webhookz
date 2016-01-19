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
			expect(response).to be_success
		end
	end

	describe 'GET #new' do
		it 'goes to a form for creating a new nation.' do
			get :new, user_id: @user.id
			expect(response).to be_success
		end
	end

	describe 'POST #create' do
		it 'creates a new nation with valid attributes' do
			expect { 
				post :create, :user_id => @user.id, :user => { :nation => { :nation_slug => "mynation", :api_key => "78838dfb730b9b60536d367de6862879de909c6af787eb74c60f7fddf31f0fa1" } } 
				}.to change(Nation, :count).by(1)
		end

		it 'fails with invalid attributes' do
			expect { 
				post :create, :user_id => @user.id, :user => { :nation => { :nation_slug => "", :api_key => "78838dfb730b9b60536d367de6862879de909c6af787ebfddf31f0fa1" } } 
				}.to change(Nation, :count).by(0)
		end
	end

	describe 'GET #edit' do
		it 'goes to a form for editing a nation.' do
			@user_nation = FactoryGirl.create(:nation, user: @user)
			get :edit, user_id: @user.id, id: @user_nation.id
			expect(response).to be_success
		end
	end


	describe 'PATCH #update' do
		before(:each) do
			@nation = FactoryGirl.create(:nation, user: @user)
		end

		it 'updates a nation with valid attributes' do 
				patch :update, :user_id => @user.id, :id => @nation.id, :user => { :nation => { :nation_slug => "organizerkevincoleman", :api_key => "78838dfb730b9b60536d367de6862879de909c6af787eb74c60f7fddf31f0fa1" } } 
				expect(Nation.first.nation_slug).to eq("organizerkevincoleman")
		end

		it 'fails with invalid attributes' do
			patch :update, :user_id => @user.id, :id => @nation.id, :user => { :nation => { :nation_slug => "", :api_key => "78838dfb730b9b60536d367de6862879de909c6af787ebfddf31f0fa1" } } 
			expect(Nation.first.nation_slug).to_not eq("")
		end
	end

	describe 'GET #cancel' do
		it 'closes the forms' do
			get :cancel, user_id: @user.id
			expect(response).to be_success
		end
	end

end
