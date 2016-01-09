FactoryGirl.define do
  factory :feed_entry do
    association :feed, factory: :feed, strategy: :build
    title {Faker::Lorem.sentence}
    link {Faker::Internet.url}
    description {Faker::Lorem.paragraph}
  end
end
