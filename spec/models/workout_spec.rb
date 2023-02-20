require 'spec_helper'

describe Workout do
  it "can be created without exercises" do
    expect(create(:workout)).to be_valid
  end
  
  it "can be created with exercises" do
    expect(create(:gpucc_workout)).to be_valid
  end  
  
  it "is invalid without a parent challenge" do
    expect(build(:workout, challenge: nil, title: 'no challenge workout')).not_to be_valid
  end
  
  it "is invalid without a start date" do
    expect(build(:workout, start_date: nil)).not_to be_valid
  end
  
  it "can span multiple days" do
    expect(create(:workout, end_date: (Date.current + 1), title: 'multi-day workout')).to be_valid
  end
  
  it "cannot be created with the same start date" do
    w = create(:gpucc_workout)
    expect(build(:gpucc_workout, challenge: w.challenge, start_date: w.start_date)).not_to be_valid
  end

  it "cannot be created with overlapping dates" do
    w = create(:gpucc_workout, end_date: Date.current + 10)
    expect(build(:gpucc_workout, challenge: w.challenge, start_date: w.start_date + 1, end_date: w.end_date - 1)).not_to be_valid
  end
  
  describe "scopes" do
    before :each do
      ca = create(:challenge_assignment)
      @user = ca.user
      @active1 =    create(:workout, start_date: Date.current, challenge: ca.challenge, title: 'Active Workout 1')
      @active2 =    create(:workout, start_date: Date.current, title: 'Active Workout 2')
      @future1 =    create(:workout, start_date: Date.current + 1, challenge: ca.challenge, title: 'Future Workout 1')
      @future2 =    create(:workout, start_date: Date.current + 1, title: 'Future Workout 2')
      @completed1 = create(:completed_workout, user: @user).workout
      @completed2 = create(:completed_workout, user: @user).workout
      @past1   =    create(:workout, start_date: Date.current - 10, challenge: ca.challenge, title: 'Past Workout 1')
      @past2   =    create(:workout, start_date: Date.current - 11, title: 'Past Workout 2')
    end
    
    it "should include active workouts" do
      expect(Workout.active(@user)).to match_array [@active1]
    end

    it "should include completed workouts" do
      expect(Workout.completed(@user)).to match_array [@completed1, @completed2]
    end

    it "should include future workouts" do
      expect(Workout.future(@user)).to match_array [@future1]
    end
    
    it "should include past workouts" do
      expect(Workout.past(@user)).to match_array [@past1]
    end  
    
  end

end
