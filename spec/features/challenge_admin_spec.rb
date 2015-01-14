require 'spec_helper'

feature "Challenge Admin", js: true, type: :feature do

	scenario "admin can create a new challenge" do

		admin = create(:test_admin)

		visit root_path  
		fill_in 'user[email]', with: admin.email
		fill_in 'user[password]', with: admin.password
		# puts "using #{admin.email}, #{admin.password}"
		# puts "Users"
		# binding.pry
		# User.all.each {|u| puts u.email + " " + u.encrypted_password}
		# binding.pry
		click_button "Sign in"		

		expect(page).to have_content('Signed in successfully.'), "No success message"
		
	end	
end