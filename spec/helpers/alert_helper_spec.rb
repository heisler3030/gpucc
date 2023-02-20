require 'spec_helper'
require 'date'
require_relative '../../app/helpers/alert_helper.rb'
include AlertHelper

describe AlertHelper do
  
  before :each do
    # Clear mailer deliveries
    ActionMailer::Base.deliveries.clear
  end

  describe "#workout_announcement_job" do
    
    before { Timecop.freeze(Date.current +  10.minutes) } # set to 12:10am
    after  { Timecop.return }
    
    it "should email the user who is assigned to the challenge" do
      ca = create(:challenge_assignment)
      w = create(:workout, challenge: ca.challenge)
      AlertHelper.workout_announcement_job
      expect(ActionMailer::Base.deliveries.first.to_s).to include "To: #{ca.user.email}"
    end

    it "should send an email for each open workout" do
      5.times do 
        ca = create(:challenge_assignment)
        w = create(:workout, challenge: ca.challenge)
      end
      AlertHelper.workout_announcement_job
      expect(ActionMailer::Base.deliveries.count).to eq(5)
    end

    it "should not send emails for future workouts" do
      5.times do
        ca = create(:challenge_assignment)
        w = create(:workout, challenge: ca.challenge, start_date: Date.current + 2)
      end
      AlertHelper.workout_announcement_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end

    it "should not send an email if the user's notification flag is disabled" do
      u = create(:test_user, notifications: false)
      ca = create(:challenge_assignment, user: u)
      w = create(:workout, challenge: ca.challenge)
      AlertHelper.workout_announcement_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
    
    it "should not send an email to disqualified participants" do
      ca = create(:disqualified_challenge_assignment)
      w = create(:workout, challenge: ca.challenge)
      AlertHelper.workout_announcement_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end

  describe "#send_workout_reminders_job" do
    
    before { Timecop.freeze(Date.current +  1390.minutes) } # set to 11:10pm
    after  { Timecop.return }    
    
    it "should send reminders to users with an incomplete workout" do
      5.times do
        ca = create(:challenge_assignment)
        create(:gpucc_workout, challenge: ca.challenge)
      end
      AlertHelper.send_workout_reminders_job
      expect(ActionMailer::Base.deliveries.count).to eq(5)
    end
        
    it "should not send reminders to users with completed workouts" do
      ca = create(:challenge_assignment)
      w = create(:gpucc_workout, challenge: ca.challenge)
      create(:completed_gpucc_workout, workout: w, user: ca.user)
      AlertHelper.send_workout_reminders_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
    
    it "should not send reminders until within the reminder threshold" do
      ca = create(:challenge_assignment)
      create(:gpucc_workout, challenge: ca.challenge)
      Timecop.freeze(Time.current - (ca.user.reminder_threshold + 1).hours)
      AlertHelper.send_workout_reminders_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
    
    it "should not send reminders to users who have been already notified" do
      ca = create(:challenge_assignment, last_notified: Time.current - 5.minutes)
      create(:gpucc_workout, challenge: ca.challenge)
      AlertHelper.send_workout_reminders_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
    
    it "should not send reminders to disqualified participants" do
      ca = create(:disqualified_challenge_assignment)
      AlertHelper.send_workout_reminders_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
    
    it "should not send reminders to users who have declined reminders" do
      u = create(:test_user, reminder_threshold: 0)
      ca = create(:challenge_assignment, user: u)
      create(:gpucc_workout, challenge: ca.challenge)
      ca.disqualify_date = Date.current
      AlertHelper.send_workout_reminders_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)      
    end
    
    it "should not send reminders on rest days" do
      ca = create(:challenge_assignment)
      create(:rest_day_workout, challenge: ca.challenge)
      AlertHelper.send_workout_reminders_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)     
    end
  end

  describe "#send_coach_reminders_job" do
    it "should notify the coach if there is no workout tomorrow" do
      ca = create(:challenge_assignment)
      create(:gpucc_workout, challenge: ca.challenge, start_date: Date.current + 2)
      AlertHelper.send_coach_reminders_job
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
    
    it "should not notify the coach if there is a workout scheduled" do
      ca = create(:challenge_assignment)
      create(:gpucc_workout, challenge: ca.challenge, start_date: Date.current + 1)
      AlertHelper.send_coach_reminders_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end

  xdescribe "#send_atrisk_reminders_job"

  xdescribe "#check_challenge_status_job"

end
