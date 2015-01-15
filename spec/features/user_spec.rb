require 'spec_helper'

feature "User", js: true, type: :feature do

	# Login Routine
	let(:user_login) do
		user = create(:test_user)
		visit new_user_session_path  
		fill_in 'user[email]', with: user.email
		fill_in 'user[password]', with: user.password
		click_button "Sign in"
	end

	scenario "can log in successfully" do
		user_login
		expect(page).to have_content('Signed in successfully.'), "No success message"
	end	
	
	scenario "cannot see admin menu" do
		user_login
		expect(page).not_to have_css('#adminmenu')
	end	
		
end