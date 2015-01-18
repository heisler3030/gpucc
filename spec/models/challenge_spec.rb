require 'spec_helper'

describe Challenge do
  it "has a valid factory" do
    expect(create(:challenge)).to be_valid
  end

  it "is invalid without a start date" do
    expect(build(:challenge, start_date: nil)).not_to be_valid
  end

  it "is invalid without an end date" do
    expect(build(:challenge, end_date: nil)).not_to be_valid
  end

  it "is invalid with an end date earlier than start date"

  it "is invalid without a title" do
    expect(build(:challenge, title: nil)).not_to be_valid
  end
  
  it "is invalid without max_misses" do
    expect(build(:challenge, max_misses: nil)).not_to be_valid
  end
  
  it "calculates the number of days remaining" do
    challenge = create(:challenge, start_date: (Date.today - 1), end_date: (Date.today + 1))
    expect(challenge.days_remaining).to eq(1)
  end
  
  it "doesn't show negative days remaining" do
    challenge = create(:challenge, start_date: (Date.today - 10), end_date: (Date.today - 5))
    expect(challenge.days_remaining).to eq(0)
  end

  it "properly identifies In Progress status"
  it "properly identifies Completed status"
  it "properly fetches active assignments"
  it "properly fetches disqualified assignments"
  it "properly fetches completed assignments"
  
  
end
