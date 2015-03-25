require 'spec_helper'

feature "Sign Up", js: true, type: :feature do
	include_context 'login methods'

	scenario "can apply, invite and register successfully" do

		# Request Invite
		visit new_user_session_path
		click_on 'Request Invite'
		fill_in 'Enter Email Address', with: 'applicant@fitstalker.com'
		click_on 'Submit'
		
		# Send Invite
		admin_login
		click_on 'Admin'
		click_on 'New User Invitation'
		fill_in 'user_email', with: 'test@fitstalker.com'
		click_on 'Send an invitation'
		expect(ActionMailer::Base.deliveries.first.to_s).to include "To: test@fitstalker.com"

		# Validate users appear in proper locations
		click_on 'Admin'
		click_on 'View Invites'
		expect(find('#applicants')).to have_text 'applicant@fitstalker.com'
		expect(find('#invites')).to have_text 'test@fitstalker.com'
		
		# Invite applicant
		ActionMailer::Base.deliveries.clear
		click_on 'Invite User'
		page.evaluate_script('window.confirm = function() { return true }') 
		click_on 'Admin'
		click_on 'View Invites'		
		expect(find('#invites')).to have_text 'applicant@fitstalker.com'
		expect(ActionMailer::Base.deliveries.first.to_s).to include "To: applicant@fitstalker.com"
		
		# Follow the link from the invite and register a new user
		visit destroy_user_session_path
		email = Nokogiri::HTML(ActionMailer::Base.deliveries.first.body.raw_source)
		visit email.at_css('a').attr('href')
		fill_in 'Name', with: 'Mr New User'
		fill_in 'Password', with: 'changeme'
		fill_in 'Password confirmation', with: 'changeme'
		select('(GMT-08:00) Pacific Time (US & Canada)', from: 'Time zone')
		check 'Receive daily email notification for new workouts?'
		select('2 hours before deadline', from: 'user_reminder_threshold')
		click_on 'Sign Up'
		
		# Validate user was registered and attributes were set properly
		expect(page).to have_content('Your password was set successfully')
		newuser = User.find_by(email: 'applicant@fitstalker.com')
		expect(newuser.name).to eq('Mr New User')
		expect(newuser.time_zone).to eq('Pacific Time (US & Canada)')
		expect(newuser.notifications).to be true
		expect(newuser.reminder_threshold).to be 2
	end	
		
end