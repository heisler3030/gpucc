

desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  Rails.logger.debug("TASK: Sending Reminders")

  ###### Participant Workout Reminders ####################################################################
  # 
  # Notify participants with incomplete workouts inside reminder threshold
  #
  #########################################################################################################

  ChallengeAssignment.active.each do |ac|

    # Only send if user wants email reminders
    if ac.user.email_reminders?

      ac.open_workouts.each do |ow|

        user = ac.user
        time_remaining = ow.time_remaining(user)

        Rails.logger.debug("\nUser: " + ac.user.name.to_s + " [" + ac.user.time_zone.to_s + "]")
        Rails.logger.debug(
          "Workout " + ow.id.to_s + 
          " ends " + ow.ends_at(user).to_time.to_s + 
          " (" + time_remaining.round(2).to_s + " hours remain)")

        if time_remaining <= user.reminder_threshold

          Rails.logger.debug("Sending Reminder")



          UserMailer.workout_reminder(user).deliver

        else
          Rails.logger.debug("Not within reminder threshold (" + user.reminder_threshold.to_s + " hours)")
        end

      end
    end
    
  end

  ###### Coach Workout Reminders ####################################################################
  # 
  # Notify coach when there is no workout scheduled for tomorrow
  #
  #########################################################################################################


  ###### Coach At Risk Workout Reminders ####################################################################
  # 
  # Notify participants with incomplete workouts inside reminder threshold
  #
  #########################################################################################################

end