FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    title      { Faker::Name.title }
    email      { Faker::Internet.safe_email(name) }
    password   { Faker::Internet.password }
    status     { [:available, :offline, :do_not_disturb].sample }

    factory :admin do
      role :admin
    end
  end
end
