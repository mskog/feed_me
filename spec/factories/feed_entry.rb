FactoryGirl.define do
  factory :feed_entry do
    association :feed, factory: :feed, strategy: :build
    title {Faker::Lorem.sentence}
    url {Faker::Internet.url}
    summary {Faker::Lorem.paragraph}
    content {Faker::Lorem.paragraph}
    author {Faker::Name.name}
  end
end
