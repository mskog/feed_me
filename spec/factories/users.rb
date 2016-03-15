FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "a"*30
  end
end
