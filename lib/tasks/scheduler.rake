require_relative '../../app/helpers/alert_helper.rb'
require_relative '../../app/helpers/gpucc_workout_helper.rb'
include AlertHelper
include GpuccWorkoutHelper

desc "This task is called by the Heroku scheduler add-on"

# Call locally by using 'rake <taskname>' - e.g. 'rake send_reminders'

task :workout_announcement => :environment do

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

  AlertHelper.workout_announcement_job

end


task :send_workout_reminders => :environment do
  puts ("TASK: User Workout Reminders")

  ###### Participant Workout Reminders ####################################################################
  # 
  # Notify participants with incomplete workouts inside reminder threshold
  #
  # => rake send_workout_reminders
  #########################################################################################################

  AlertHelper.send_workout_reminders_job

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

  AlertHelper.send_coach_reminders_job

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

  AlertHelper.send_atrisk_reminders_job

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

  AlertHelper.check_challenge_status_job

end

task :gpucc_workout_helper => :environment do
  puts ("TASK: GPUCC workout monitor")

  ###### GPUCC workout monitor ####################################################################
  # 
  # Sweeps to create a gpucc workout if none was created
  #
  # => rake auto_gpucc_workout
  #
  #########################################################################################################

  GpuccWorkoutHelper.auto_gpucc_workout('GPUCC 2015')

end