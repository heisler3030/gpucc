# Read about factories at https://github.com/thoughtbot/factory_girl
require 'date'

FactoryBot.define do
  factory :completed_workout do
    association :user, factory: :test_user
    workout
    complete_time { Time.now - 1.hours }
    
    factory :completed_gpucc_workout do
      association :workout, factory: :gpucc_workout
    end
    
  end

end