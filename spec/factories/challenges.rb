# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :challenge do
    title
    description
    start_date
    end_date
    max_misses
    join_by
    association :owner, factory: :trainer
  end
  
end