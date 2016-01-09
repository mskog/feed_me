FactoryGirl.define do
  factory :feed do
    title {Faker::Lorem.sentence}
    url {Faker::Internet.url}
    description {Faker::Lorem.paragraph}
  end
end
