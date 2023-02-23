# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do

  factory :user do
    password { 'changeme' }
    password_confirmation { 'changeme' }
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) {|n| "user#{n}@fitstalker.com" }
    reminder_threshold { 4 }
    time_zone { "UTC" }

    factory :test_user, class: User do
      after(:create) do |user|
        user.add_role :user
      end
    end

    factory :test_trainer, class: User do
      after(:create) do |user|
        user.add_role :trainer
      end
    end
    
    factory :test_admin, class: User do
      after(:create) do |user|
        user.add_role :admin
      end
    end

  end

end
