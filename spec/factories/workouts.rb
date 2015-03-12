# Read about factories at https://github.com/thoughtbot/factory_girl
require 'date'

FactoryGirl.define do
  factory :workout, class: Workout do
    sequence(:title) {|n| "Awesome Workout #{n}" }
    motivation "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    start_date Date.today
    end_date nil
    challenge
    rest_day nil

    factory :gpucc_workout do
      after(:build) do |workout, evaluator|
        create(:pushups_assignment, workout: workout)
        create(:situps_assignment, workout: workout)
      end
    end
    
    factory :rest_day_workout do
      rest_day true
    end

  end
  
  
end