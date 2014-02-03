desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  Rails.logger.debug("TASK: Sending Reminders")
  
  # For every user with challengeassignments without null completed_date or disqualify


  reminders_needed = ChallengeAssignment.where("completed_date is null OR disqualify_date is null")

  Rails.logger.debug(reminders_needed.inspect)

  reminders_needed.each do |r|

  end

  # For every challenge assignment where completed_date is null or disqualify_date is null

end