require 'spec_helper'

feature "Administrator", js: true, type: :feature do

	# Login Routine
	let(:admin_login) do
		admin = create(:test_admin)
		visit new_user_session_path  
		fill_in 'user[email]', with: admin.email
		fill_in 'user[password]', with: admin.password
		click_button "Sign in"
	end

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
		find('#challenge_description').set('Amazing challenge description')
		Capybara.ignore_hidden_elements = true
		fill_in 'challenge_max_misses', with: '5'
		find('#challenge_join_by').click
		find('th.next').click
		find(:xpath, "//td[contains(@class, 'day')][text()='15']").click
		expect { click_on "Create Challenge" }.to change(Challenge, :count).by(1)
	end
		
end