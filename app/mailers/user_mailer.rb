class UserMailer < ActionMailer::Base
  default :from => ENV["GMAIL_USERNAME"]

	def workout_reminder(user,workout)
		subject = "Workout Reminder"
		
		@user = user
		@workout = workout

		mail(:to => user.email, :subject => subject)
	end

	def workout_announcement(user,workout)
		subject = "Workout for " + workout.effective_date

		@user = user
		@workout = workout
		@trainer = workout.challenge.owner

		mail(:to => user.email, :subject => subject)
	end

	def no_workout_scheduled_reminder(user,challenge)
		subject = "No Workout Warning"

		@user = user
		@challenge = challenge
		
		mail(:to => user.email, :subject => subject)
	end

end
