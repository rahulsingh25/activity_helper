FactoryGirl.define do
  factory :user do
    sequence(:username)  { |n| "Person_#{n}" }
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"} 
    password "foobar123"
    password_confirmation "foobar123"
  end

  factory :activity do
    category "Sports"
    name "Football"
    description "I like Football"
    user
  end

  factory :comment do
    content "hello"
    user
    activity
  end

  factory :friendship do
    user
    friend_id 1
    status "false"
  end
end