# Read about factories at https://github.com/thoughtbot/factory_girl
require 'date'

FactoryGirl.define do
  factory :completed_workout do
    association :user, factory: :test_user
    workout
    
    factory :completed_gpucc_workout do
      association :workout, factory: :gpucc_workout
    end
    
  end

end