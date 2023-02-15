# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :goal_type do
    title { "Cumulative" }
    description { "Cumulative Goal over the entire workout period" }
  end
  
end
