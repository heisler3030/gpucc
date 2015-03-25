require 'spec_helper'

feature "Administrator", js: true, type: :feature do
	include_context 'login methods'

	scenario "can log in successfully" do
		admin_login
		expect(page).to have_content('Signed in successfully.'), "No success message"
	end	
	
	scenario "can see admin menu" do
		admin_login
		expect(page).to have_css('#adminmenu')
	end	

	scenario "can create a new challenge" do
		admin_login
		click_on('Admin')
		click_on('New Challenge')
		expect(current_path).to eq(new_challenge_path)
		fill_in 'Title', with: 'Feature Test Challenge'
		find('#challenge_start_date').click
		find('th.today').click
		find('#challenge_end_date').click
		find('th.next').click
		find(:xpath, "//td[contains(@class, 'day')][text()='19']").click
		Capybara.ignore_hidden_elements = false
		# Might need to change this to get the actual description to populate?
		find('#challenge_description').set('Amazing challenge description')
		Capybara.ignore_hidden_elements = true
		fill_in 'challenge_max_misses', with: '5'
		find('#challenge_join_by').click
		find('th.next').click
		find(:xpath, "//td[contains(@class, 'day')][text()='15']").click
		expect { click_on "Create Challenge" }.to change(Challenge, :count).by(1)
	end

	xscenario "can edit their challenge details"
	xscenario "can add a workout to a challenge"
	xscenario "can create a rest day workout"
	xscenario "can excuse an incomplete workout"
	xscenario "can add a completed set for one of their trainees"
		
end