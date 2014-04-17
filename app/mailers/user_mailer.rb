class UserMailer < ActionMailer::Base
  default :from => ENV["GMAIL_USERNAME"]

	def workout_reminder(user)
		mail(:to => user.email, :subject => "Workout Reminder")
	end
end
