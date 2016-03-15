FactoryGirl.define do
  factory :user_feed do
    association :user, factory: :user, strategy: :build
    association :feed, factory: :feed, strategy: :build
  end
end
