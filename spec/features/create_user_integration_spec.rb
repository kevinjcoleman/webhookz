require 'rails_helper'

feature 'Creates user' do

  	scenario 'with valid user credentials' do
	    visit new_user_registration_path
	    fill_in 'Email', with: 'newuser@example.com'
	    fill_in 'Password', with: 'password' 
	    fill_in 'Password confirmation', with: 'password' 
	    click_on 'Sign up'

	    expect(page).to have_content('Welcome! You have signed up successfully.')
	end

	scenario 'with invalid email' do
	    visit new_user_registration_path
	    fill_in 'Email', with: 'newuser@example'
	    fill_in 'Password', with: 'password' 
	    fill_in 'Password confirmation', with: 'password' 
	    click_on 'Sign up'

	    expect(page).to have_content('Email is invalid')
	end

	scenario 'with invalid password' do
	    visit new_user_registration_path
	    fill_in 'Email', with: 'newuser@example.com'
	    fill_in 'Password', with: '' 
	    fill_in 'Password confirmation', with: '' 
	    click_on 'Sign up'

	    expect(page).to have_content('Password can\'t be blank')
	end

	scenario 'with not matching passwords' do
	    visit new_user_registration_path
	    fill_in 'Email', with: 'newuser@example.com'
	    fill_in 'Password', with: 'password' 
	    fill_in 'Password confirmation', with: '' 
	    click_on 'Sign up'

	    expect(page).to have_content('Password confirmation doesn\'t match Password')
	end
end
