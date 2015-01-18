# Read about factories at https://github.com/thoughtbot/factory_girl
require 'date'

FactoryGirl.define do
  factory :challenge do
    sequence(:title) {|n| "Awesome Challenge #{n}" }
    description "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    start_date Date.today
    end_date Date.today + 30
    max_misses 5
    join_by Date.today + 10
    association :owner, factory: :test_trainer

    factory :expired_challenge do
      title "Expired Challenge"
      description "This challenge is expired and should therefore not show up as available"
      start_date Date.today - 60
      end_date Date.today - 30
      join_by Date.today - 50
    end
      

  end
  
  
end