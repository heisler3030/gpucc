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
    
    before { Timecop.freeze(Time.parse("12:10am")) }
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
        w = create(:workout, challenge: ca.challenge, start_date: Date.today + 2)
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
      ca = create(:challenge_assignment, disqualify_date: Date.today)
      w = create(:workout, challenge: ca.challenge)
      AlertHelper.workout_announcement_job
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end

  describe "#send_workout_reminders_job" do
    
    before { Timecop.freeze(Time.parse("11:10pm")) }
    after  { Timecop.return }    
    
    it "should send reminders to users with an incomplete workout" do
      5.times do
        ca = create(:challenge_assignment)
        w = create(:gpucc_workout, challenge: ca.challenge)
      end
      AlertHelper.send_workout_reminders_job
      expect(ActionMailer::Base.deliveries.count).to eq(5)
    end
        
    it "should not send reminders to users with completed workouts"
    it "should not send reminders until within the reminder threshold"
    it "should not send reminders to users who have been already notified"
    it "should not send reminders to disqualified participants"
    it "should not send reminders to users who have declined reminders"
    it "should not send reminders on rest days"
  end

  describe "#send_coach_reminders_job" do
    it "should notify the coach if there is no workout tomorrow"
    it "should not notify the coach if there is a workout scheduled"
  end

  xdescribe "#send_atrisk_reminders_job"

  xdescribe "#check_challenge_status_job"

end