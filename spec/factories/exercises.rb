# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exercise do
    name "Generic Exercise"
  
    factory :pushups do
      name "Pushups"
    end
    
    factory :situps do
      name "Situps"
    end
  
  end
  
end
