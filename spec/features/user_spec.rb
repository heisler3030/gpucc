require 'spec_helper'

feature "User", js: true, type: :feature do
	include_context 'login methods'

	scenario "can log in successfully" do
		user_login
		expect(page).to have_content('Signed in successfully.'), "No success message"
	end	
	
	scenario "cannot see admin menu" do
		user_login
		expect(page).not_to have_css('#adminmenu')
	end	

	xscenario "can complete a workout"
	xscenario "cannot complete a workout after time is up"
	xscenario "can edit a completed set"
	xscenario "cannot edit a completed set after time is up"
	
		
end