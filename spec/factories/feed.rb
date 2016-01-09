FactoryGirl.define do
  factory :feed do
    title {Faker::Lorem.sentence}
    link {Faker::Internet.url}
    description {Faker::Lorem.paragraph}
  end
end
