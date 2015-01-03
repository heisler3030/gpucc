# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :test_user, class: User do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) {|n| "user#{n}@fitstalker.com" }
    password 'changeme'
    password_confirmation 'changeme'
    after(:create) do |user|
      user.add_role :user
    end
  end

  factory :test_trainer, class: User do
    sequence(:name) { |n| "Trainer #{n}" }
    sequence(:email) {|n| "trainer#{n}@fitstalker.com" }
    password 'changeme'
    password_confirmation 'changeme'
    after(:create) do |user|
      user.add_role :trainer
    end
  end
  
  factory :test_admin, class: User do
    sequence(:name) { |n| "Admin #{n}" }
    sequence(:email) {|n| "admin#{n}@fitstalker.com" }
    password 'changeme'
    password_confirmation 'changeme'
    after(:create) do |user|
      user.add_role :admin
    end
  end  

end
