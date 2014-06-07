class UserMailer < ActionMailer::Base
  default :from => ENV["GMAIL_USERNAME"]

	def workout_reminder(user)
		mail(:to => user.email, :subject => "Workout Reminder")
	end

	def workout_announcement(user,workout)
		subject = "Workout for " + workout.effective_date
		
		mail(:to => user.email, :subject => subject)
	end

	def no_workout_scheduled_reminder(user,challenge)
		subject = "No Workout Warning"

		@user = user
		@challenge = challenge
		
		mail(:to => user.email, :subject => subject)
	end




end
