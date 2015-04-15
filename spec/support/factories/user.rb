FactoryGirl.define do
  factory :user do
    email 'jdoe@example.com'
    password 'foo'
    first_name 'John'
    last_name 'Doe'
  end
end
