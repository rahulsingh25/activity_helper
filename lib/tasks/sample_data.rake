namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar123",
                 password_confirmation: "foobar123")
    7.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               

    users = User.all(limit: 6)
      35.times do |n|
        category = "category-#{n}"
         name = Faker::Name.name
         description = Faker::Lorem.sentence(5)
      users.each { |user| user.activities.create!(category: category,name: name,description: description) }
    end
  end
end