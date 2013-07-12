FactoryGirl.define do
  factory :user do
    name "Rahul Singh"
    email "rahul692000@gmail.com"  
    password "foobar123"
    password_confirmation "foobar123"
  end

  factory :activity do
    category "Sports"
    name "Football"
    description "I like Football"
    user
  end
end