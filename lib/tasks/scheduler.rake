

desc "This task is called by the Heroku scheduler add-on"

# Call locally by using 'rake <taskname>' - e.g. 'rake send_reminders'

task :workout_announcement => :environment do
  Rails.logger.debug("TASK: Sending Workout Announcements")

  ###### Participant Workout Announcements ####################################################################
  # 
  # Daily notification of new workout info
  # Run at 12:15AM local time
  #
  # TODO: This will send a notification daily for incomplete multi-day workouts
  #########################################################################################################

  ChallengeAssignment.active.each do |ca|
    if ca.user.workout_notifications?
      ca.open_workouts.each do |ow|

        if ca.user.current_time.between?(Time.parse("12:00am"), Time.parse("12:45am")) 
          
            Rails.logger.debug("Sending Workout announce to " + ca.user.name.to_s + " for " + ow.effective_date)
            
            # Send reminder email
            UserMailer.workout_announcement(ca.user, ow).deliver
        end
      end      
    end
  end

end


task :send_workout_reminders => :environment do
  Rails.logger.debug("TASK: Sending Reminders")

  ###### Participant Workout Reminders ####################################################################
  # 
  # Notify participants with incomplete workouts inside reminder threshold
  #
  #########################################################################################################

  ChallengeAssignment.active.each do |ca|

    # Only send if user wants email reminders and they were not notified today
    if ca.user.email_reminders? && (ca.last_notified.nil? || ca.last_notified < DateTime.now.beginning_of_day)

      ca.open_workouts.each do |ow|

        # No reminders for rest days
        unless ow.rest_day?
          user = ca.user
          time_remaining = ow.time_remaining(user)

          Rails.logger.debug("\nUser: " + ca.user.name.to_s + " [" + ca.user.time_zone.to_s + "]")
          Rails.logger.debug(
            "Workout " + ow.id.to_s + 
            " ends " + ow.ends_at(user).to_time.to_s + 
            " (" + time_remaining.round(2).to_s + " hours remain)")

          if time_remaining <= user.reminder_threshold

            Rails.logger.debug("Sending Reminder")
            
            # Send reminder email
            UserMailer.workout_reminder(user).deliver
            
            # Set last_notified flag to current date
            ca.last_notified = Time.now
            ca.save

          else
            Rails.logger.debug("Not within reminder threshold (" + user.reminder_threshold.to_s + " hours)")
          end
        end
      end
    end
    
  end
end

task :send_coach_reminders => :environment do
  Rails.logger.debug("TASK: Sending Coach Reminders")

  ###### Coach Workout Reminders ####################################################################
  # 
  # Notify coach when there is no workout scheduled for tomorrow
  #
  #########################################################################################################

  Challenge.active.each do |c|
    tomorrow = Time.now.to_date + 1.day

    Rails.logger.debug "Today: " + Time.now.to_date.to_s
    Rails.logger.debug "Tomorrow: " + tomorrow.to_s

    if c.get_active_workouts_for_day(tomorrow).size == 0
      Rails.logger.debug("Sending NoWorkoutScheduled Reminder for " + c.title)              
      UserMailer.no_workout_scheduled_reminder(c.owner,c).deliver  
    end
  end

end

task :send_atrisk_reminders => :environment do
  Rails.logger.debug("TASK: Sending At Risk Coach Reminders")

  ###### Coach At Risk Workout Reminders ####################################################################
  # 
  # Notify participants with incomplete workouts inside reminder threshold
  #
  #########################################################################################################

end


task :check_challenge_status => :environment do
  Rails.logger.debug("TASK: Checking Challenge Status")

  ###### Participant Disqualification Calculation #########################################################
  # 
  # Reset qualification flags according to number of missed days / max misses
  #
  # TODO: This can probably be made more efficient by not considering ALL assignments
  #########################################################################################################

  #ChallengeAssignment.active.each { |ca| ca.check_status }

  ChallengeAssignment.all.each { |ca| ca.check_status }
  

end