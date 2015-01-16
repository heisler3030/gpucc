require 'spec_helper'

describe Workout do
  it "can be created without exercises" do
    expect(create(:workout)).to be_valid
  end
  
  it "can be created with exercises" do
    expect(create(:gpucc_workout)).to be_valid
  end  
  
  it "is invalid without a parent challenge" do
    expect(build(:workout, challenge: nil)).not_to be_valid
  end
  
  it "is invalid without a start date" do
    expect(build(:workout, start_date: nil)).not_to be_valid
  end
  
  it "can span multiple days" do
    expect(create(:workout, end_date: (Date.today + 1))).to be_valid
  end
  
end
