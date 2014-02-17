

desc "This task is called by the Heroku scheduler add-on"
task :send_reminders => :environment do
  Rails.logger.debug("TASK: Sending Reminders")
  
  # For every challengeassignments without null completed_date or disqualify
  # and where the user has opted to receive reminder emails
  # See if there is an "open workout" - e.g. one which is active "today" (in their local timezone?)
  # - meaning it has a start_date of today with null end date or has an end_date of today
  # - and that it does NOT have a corresponding completedworkout
  #
  # What you have now is all the challengeassignments requiring notification
 


  reminders_needed = ChallengeAssignment.where("completed_date is null OR disqualify_date is null")



  Rails.logger.debug(reminders_needed.inspect)

  reminders_needed.each do |r|

  end

  # For every challenge assignment where completed_date is null or disqualify_date is null

end