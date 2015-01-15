# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :applicant do
    sequence(:email) {|n| "applicant#{n}@fitstalker.com" }
  end
end
