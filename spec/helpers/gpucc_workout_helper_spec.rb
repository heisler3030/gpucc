require 'spec_helper'
require 'date'
require_relative '../../app/helpers/gpucc_workout_helper.rb'
include GpuccWorkoutHelper

describe GpuccWorkoutHelper do
  
  before :each do
    create(:goal_type)
    create(:pushups)
    create(:situps)
    ActionMailer::Base.deliveries.clear
    
    @ca = create(:challenge_assignment)
    create(:workout, challenge: @ca.challenge, start_date: Date.today - 1)
    create(:workout, challenge: @ca.challenge, start_date: Date.today)
  end
  
  describe "#auto_gpucc_workout" do
    
    it "should create a workout if none exists for tomorrow" do
      expect{
        GpuccWorkoutHelper.auto_gpucc_workout(@ca.challenge.title)
      }.to change{@ca.challenge.workouts.count}.by(1)
    end
    
    it "should not create a workout if there is already one for tomorrow" do
      create(:workout, challenge: @ca.challenge, start_date: Date.today + 1)
      expect{
        GpuccWorkoutHelper.auto_gpucc_workout(@ca.challenge.title)
      }.to_not change{@ca.challenge.workouts.count}
    end
    
    it "should match the count of days in the year" do 
      GpuccWorkoutHelper.auto_gpucc_workout(@ca.challenge.title)
      expect(@ca.challenge.workouts.last.workout_exercises.first.goal).to eq(Date.today.yday + 1)
    end
    
    xit "should email the challenge organizer when a workout is automatically created" do
      GpuccWorkoutHelper.auto_gpucc_workout(@ca.challenge.title)
      expect(ActionMailer::Base.deliveries.first.to_s).to include "To: #{@ca.challenge.owner.email}"
    end

  end

end
