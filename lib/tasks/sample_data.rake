namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_entries
    make_relationships
    make_comments
  end
end

def make_users
  User.create!( name: "Example User", email: "example@railstutorial.org",
    password: "foobar", password_confirmation: "foobar")
  99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password  = "password"
  User.create!(name:     name,
               email:    email,
               password: password,
               password_confirmation: password)
  end
end

def make_entries
  users = User.all(limit: 6)
  50.times do |n|
    title = "Entry Title No #{n}"
    body  = Faker::Lorem.sentences(10).join(" ")
    users.each { |user| user.entries.create!(title: title, body: body) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_comments
  entries = Entry.all(limit: 10)
  users = User.all(limit: 3)
  5.times do |n|
    entries.each do |entry| 
      users.each do |user|
        content = Faker::Lorem.sentence(2)
        entry.comments.create!(content: content, user_id: user.id)
      end
    end
  end
end