FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    title      { Faker::Name.title }
    email      { Faker::Internet.safe_email("#{first_name} #{last_name}") }
    password   { Faker::Internet.password }
    status     { [:available, :offline, :do_not_disturb].sample }

    trait :as_admin do
      role :admin
    end
  end
end
