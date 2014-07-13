

desc "This task is called by the Heroku scheduler add-on"

# Call locally by using 'rake <taskname>' - e.g. 'rake send_reminders'

task :workout_announcement => :environment do
  puts ("TASK: Sending Workout Announcements")

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

  puts ("Found #{active_assignments.size} active ChallengeAssignments")

  active_assignments.each do |ca|
    user = ca.user

    if user.workout_notifications?

      open_workouts = ca.open_workouts

      puts ("Found #{open_workouts.size} Open Workouts for #{ca.name} on #{user.current_date}")      
      open_workouts.each do |ow|
        
        current_user_time = user.current_time
        user_notify_time = Time.find_zone(user.time_zone).parse("12:00am")


         puts ("Current Time for #{ca.name} is #{current_user_time}")
         puts ("Waiting until #{user_notify_time} to notify")

        if user.current_time.between?(user_notify_time, user_notify_time + 45.minutes) 
          
            puts ("Sending Workout announce to #{user.name} for #{ow.effective_date}")
            
            # Send announcement email
            UserMailer.workout_announcement(user, ow).deliver
        end
      end      
    end
  end

end


task :send_workout_reminders => :environment do
  puts ("TASK: User Workout Reminders")

  ###### Participant Workout Reminders ####################################################################
  # 
  # Notify participants with incomplete workouts inside reminder threshold
  #
  # => rake send_workout_reminders
  #########################################################################################################

  ChallengeAssignment.active.each do |ca|

    # Only send if user wants email reminders and they were not notified today
    puts ("Processing: #{ca.name}")
    puts ("  - email_reminders? #{ca.user.email_reminders?}")
    puts ("  - last_notified: #{ca.last_notified}")
    puts ("  - user time: #{Time.find_zone(ca.user.time_zone).now} [#{ca.user.time_zone.to_s}]")

    if ca.user.email_reminders? && (ca.last_notified.nil? || ca.last_notified < Time.find_zone(ca.user.time_zone).now.to_date)

      puts ("  - user has NOT been notified already")
      # Should make this handle nil better - modify ca.last_notified method?  Should not just fire immediately when last_notified = nil
      # Probably should refactor to ask something which can take into account requested reminder window (e.g. 2 hours before, 4 hours before, etc)
      # Seems to just fire immediately every time - something wrong with if logic?

      ca.open_workouts.each do |ow|
        puts "\n   Processing #{ow.effective_date}"

        # No reminders for rest days
        unless ow.rest_day?
          user = ca.user
          time_remaining = ow.time_remaining(user)

          puts (
            "   Workout ends " + ow.ends_at(user).to_time.to_s + 
            " (" + time_remaining.round(2).to_s + " hours remain)")

          if time_remaining <= user.reminder_threshold

            puts ("   Sending Reminder")
            
            # Send reminder email
            UserMailer.workout_reminder(user,ow).deliver
            
            # Set last_notified flag to current date
            ca.last_notified = Time.find_zone(ca.user.time_zone).now.to_date
            ca.save

          else
            puts ("   Not within reminder threshold (" + user.reminder_threshold.to_s + " hours)")
          end
        else
          puts ("   REST DAY, no reminder")
        end
      end
    else
      puts ("  - user has been notified already - terminating")
    end
    
  end
end

task :send_coach_reminders => :environment do
  puts ("TASK: Sending Coach Reminders")

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
      puts ("Sending NoWorkoutScheduled Reminder for " + c.title)              
      UserMailer.no_workout_scheduled_reminder(c.owner,c).deliver  
    end
  end

end

task :send_atrisk_reminders => :environment do
  puts ("TASK: Sending At Risk Coach Reminders")

  ###### Coach At Risk Workout Reminders ####################################################################
  # 
  # Notify participants with incomplete workouts inside reminder threshold
  #
  # => rake send_atrisk_reminders
  #
  #########################################################################################################

end


task :check_challenge_status => :environment do
  puts ("TASK: Checking Challenge Status")

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