# Read about factories at https://github.com/thoughtbot/factory_girl
require 'date'

FactoryGirl.define do
  factory :challenge_assignment do
    challenge
    association :user, factory: :test_user  

    factory :completed_challenge_assignment do
      completed_date Date.today - 10
    end
      
    factory :disqualified_challenge_assignment do
      disqualify_date Date.today - 10
    end
  end
  
  
end