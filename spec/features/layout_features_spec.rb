require 'rails_helper'

feature 'Layout features' do
  	scenario 'Not signed in' do
	    visit root_path
	    expect(page).to have_content('Create account')
	    expect(page).to have_content('Sign in')
	end

	scenario 'Signed in' do
		user = FactoryGirl.create(:user)
		login_as(user, :scope => :user)
	    visit root_path
	    expect(page).to have_link('Nations', user_path(user))
		expect(page).to have_content('Sign out')
	    expect(page).to have_content('Nations')
	    expect(page).to have_content('Settings')
	    expect(page).to have_content('Account')
	end
end
