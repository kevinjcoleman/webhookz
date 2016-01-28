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
	    sleep(2)
	    expect(page).to have_content("mynation was created!")
	    expect(page).to_not have_content("No current nations")
	end

	scenario 'view own nation page, edit existing nation, make sure it\'s invalid', :js => true do
		@nation = FactoryGirl.create(:nation, user: @user)
		visit user_path(@user)
		expect(page).to have_content("Nations")
		expect(page).to have_content("Add another nation")
		click_on "edit#{@nation.id}"
		page.find_field('Nation slug').set('organizerkevincoleman')
	    fill_in 'Api key', with: '78838dfb730b9b60536d367de6862879de909c6af787eb74c60f7fddf31f0fa1' 
	    click_on 'Edit nation'
	    sleep(2)
	    expect(page).to have_selector :css, "#nation-#{@nation.id}.api-uninitialized"
	end

	scenario 'view own nation page, add a webhook', :js => true do
		@nation = FactoryGirl.create(:nation, user: @user)
		visit user_path(@user)
	    click_on "Webhooks "
	    click_on "nation-new-webhook-#{@nation.id}"
	    expect(page).to have_content("Create a webhook")
	    within '#user_webhook_event' do
	    	find("option[value='When a person is created.']").click
	    end
	    click_on "Create webhook"
	    expect(page).to have_content("webhook was created!")
	end	

	scenario 'try to visit different user\'s nations page' do 
		@other_user = FactoryGirl.create(:user, :other_user)
		visit user_path(@other_user)
		expect(page).to have_content("You can't access that page")
	end
end