

desc "This task is called by the Heroku scheduler add-on"

# Call locally by using 'rake <taskname>' - e.g. 'rake send_reminders'

task :workout_announcement => :environment do
  Rails.logger.debug("TASK: Sending Workout Announcements")

  ###### Participant Workout Announcements ####################################################################
  # 
  # Daily notification of new workout info
  # Runs Hourly at xx:10
  # Notifies at midnight local time (based on user timezone)
  #
  # => rake workout_announcement
  #
  # TODO: This will send a notification daily for incomplete multi-day workouts
  #########################################################################################################

  active_assignments = ChallengeAssignment.active

  Rails.logger.debug("Found #{active_assignments.size} active ChallengeAssignments")

  active_assignments.each do |ca|
    user = ca.user

    if user.workout_notifications?

      open_workouts = ca.open_workouts

      Rails.logger.debug("Found #{open_workouts.size} Open Workouts for #{ca.name} on #{user.current_date}")      
      open_workouts.each do |ow|
        
        current_user_time = user.current_time
        user_notify_time = Time.find_zone(user.time_zone).parse("12:00am")


         Rails.logger.debug("Current Time for #{ca.name} is #{current_user_time}")
         Rails.logger.debug("Waiting until #{user_notify_time} to notify")

        if user.current_time.between?(user_notify_time, user_notify_time + 45.minutes) 
          
            Rails.logger.debug("Sending Workout announce to #{user.name} for #{ow.effective_date}")
            
            # Send announcement email
            UserMailer.workout_announcement(user, ow).deliver
        end
      end      
    end
  end

end


task :send_workout_reminders => :environment do
  Rails.logger.debug("TASK: Sending Reminders")
  puts "Heroku Testing"

  ###### Participant Workout Reminders ####################################################################
  # 
  # Notify participants with incomplete workouts inside reminder threshold
  #
  # => rake send_workout_reminders
  #########################################################################################################

  ChallengeAssignment.active.each do |ca|

    # Only send if user wants email reminders and they were not notified today
    Rails.logger.debug("ca.user.email_reminders? #{ca.user.email_reminders?}")
    Rails.logger.debug("ca.last_notified.nil? #{ca.last_notified.nil?}")
    Rails.logger.debug("ca.last_notified #{ca.last_notified}")
    Rails.logger.debug("Time.find_zone(ca.user.time_zone).now.to_date #{Time.find_zone(ca.user.time_zone).now.to_date}")

    if ca.user.email_reminders? && (ca.last_notified.nil? || ca.last_notified < Time.find_zone(ca.user.time_zone).now.to_date)

      # Should make this handle nil better - modify ca.last_notified method?  Should not just fire immediately when last_notified = nil
      # Probably should refactor to ask something which can take into account requested reminder window (e.g. 2 hours before, 4 hours before, etc)
      # Seems to just fire immediately every time - something wrong with if logic?

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
            UserMailer.workout_reminder(user,ow).deliver
            
            # Set last_notified flag to current date
            ca.last_notified = Time.find_zone(ca.user.time_zone).now.to_date
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
  # => rake send_coach_reminders
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
  # => rake send_atrisk_reminders
  #
  #########################################################################################################

end


task :check_challenge_status => :environment do
  Rails.logger.debug("TASK: Checking Challenge Status")

  ###### Participant Disqualification Calculation #########################################################
  # 
  # Reset qualification flags according to number of missed days / max misses
  #
  # => rake check_challenge_status
  #
  # TODO: This can probably be made more efficient by not considering ALL assignments
  #########################################################################################################

  #ChallengeAssignment.active.each { |ca| ca.check_status }

  ChallengeAssignment.all.each { |ca| ca.check_status }
  

end