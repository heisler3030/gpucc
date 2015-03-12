require 'spec_helper'

describe ChallengeAssignment do
  describe "ChallengeAssignment scopes" do
    before :each do
      @dq1 = create(:disqualified_challenge_assignment)
      @dq2 = create(:disqualified_challenge_assignment)
      @complete1 = create(:completed_challenge_assignment)
      @complete2 = create(:completed_challenge_assignment)
      @open1 = create(:challenge_assignment)
      @open2 = create(:challenge_assignment)
    end
    
    it "should return active challenge_assignments" do
      expect(ChallengeAssignment.active).to match_array [@open1, @open2]
    end
    
    it "should return completed challenge_assignments" do
      expect(ChallengeAssignment.completed).to match_array [@complete1, @complete2]
    end
    
    it "should return disqualified challenge_assignments" do
      expect(ChallengeAssignment.disqualified).to match_array [@dq1, @dq2]
    end
    
    it "should return inactive challenge_assignments" do
      expect(ChallengeAssignment.inactive).to match_array [@complete1, @complete2, @dq1, @dq2]
    end
    
  end
  
  
  it "should return the proper number of remaining misses"
  it "should not return negative misses"
end
