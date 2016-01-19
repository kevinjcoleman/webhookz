require 'rails_helper'

feature 'Nation page' do
	before(:each) do
		@user = FactoryGirl.create(:user)
		login_as(@user, :scope => :user)
	end

  	scenario 'view own nation page, create valid nation, see new nation', :js => true do
		visit user_path(@user)
		expect(page).to have_content("Nations")
		expect(page).to have_content("No current nations")
		click_on 'Create a nation'
		page.find_field('Nation slug').set('mynation')
	    fill_in 'Api key', with: '78838dfb730b9b60536d367de6862879de909c6af787eb74c60f7fddf31f0fa1' 
	    click_on 'Create nation'
	    expect(page).to have_content("mynation was created!")
	    expect(page).to_not have_content("No current nations")
	end

	scenario 'view own nation page, edit existing nation', :js => true do
		@nation = FactoryGirl.create(:nation, user: @user)
		visit user_path(@user)
		expect(page).to have_content("Nations")
		expect(page).to have_content("Add another nation")
		click_on "edit#{@nation.id}"
		page.find_field('Nation slug').set('organizerkevincoleman')
	    fill_in 'Api key', with: '78838dfb730b9b60536d367de6862879de909c6af787eb74c60f7fddf31f0fa1' 
	    click_on 'Edit nation'

	end

	scenario 'try to visit different user\'s nations page' do 
		@other_user = FactoryGirl.create(:user, :other_user)
		visit user_path(@other_user)
		expect(page).to have_content("You can't access that page")
	end
end