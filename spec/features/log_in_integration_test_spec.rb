require 'rails_helper'

feature 'User signs in' do
	before(:each) do
		@user = FactoryGirl.create(:user)
	end
  	scenario 'with created user credentials' do
	    visit new_user_session_path
	    fill_in 'Email', with: @user.email
	    fill_in 'Password', with: @user.password 
	    click_on 'Log in'

	    expect(page).to have_content('Signed in successfully.')
	end

	scenario 'with credientials that don\'t exist' do
	    visit new_user_session_path
	    fill_in 'Email', with: 'kevin@example.com'
	    fill_in 'Password', with: 'password' 
	    click_on 'Log in'

	    expect(page).to have_content('Invalid email or password')
	end

	scenario 'Sign in with invalid email and name' do
		visit new_user_session_path
	    fill_in 'Email', with: 'kevin@example'
	    fill_in 'Password', with: '2' 
	    click_on 'Log in'

	    expect(page).to have_content('Invalid email or password')
	end
end
