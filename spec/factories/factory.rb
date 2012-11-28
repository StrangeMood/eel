FactoryGirl.define do
  sequence(:random_string) {|n| Faker::Lorem.words }
  sequence(:random_text) {|n| Faker::Lorem.paragraph }

  factory :user, aliases: [:author, :commenter] do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end

  factory :post do
    author

    post_date { Date.today }
    title { generate(:random_string) }
    text { generate(:random_text) }
  end

  factory :comment do
    commenter
    association :parent, factory: :post

    comment_date { Date.today }
    text { generate(:random_text) }
  end
end