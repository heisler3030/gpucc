# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :workout_exercise do
    goal { 90 }
    workout
    exercise
    goal_type
  
    factory :pushups_assignment do
      association :exercise, factory: :pushups
    end
    
    factory :situps_assignment do
      association :exercise, factory: :situps
    end
  
  end
  
end
