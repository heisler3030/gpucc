# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :exercise do
    sequence(:name) { |n| "Exercise #{n}" }
    initialize_with { Exercise.find_or_create_by(name: name) } # Use existing record if present
  
    factory :pushups do
      name 'Pushups'
    end
    
    factory :situps do
      name 'Situps'
    end
    
  end
  
end
