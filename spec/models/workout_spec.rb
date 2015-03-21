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
    expect(create(:workout, end_date: (Date.today + 1), title: 'multi-day workout')).to be_valid
  end
  
  it "cannot be created with the same start date" do
    w = create(:gpucc_workout)
    expect(build(:gpucc_workout, challenge: w.challenge, start_date: w.start_date)).not_to be_valid
  end

  it "cannot be created with overlapping dates" do
    w = create(:gpucc_workout, end_date: Date.today + 10)
    expect(build(:gpucc_workout, challenge: w.challenge, start_date: w.start_date + 1, end_date: w.end_date - 1)).not_to be_valid
  end
  
end
