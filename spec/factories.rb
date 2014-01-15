FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
    	admin true
    end
  end

  factory :entry do
    sequence(:title) { |n| "Entry No.#{n}" }
    sequence(:body) { |n| "Body of entry No.#{n}" }
    user
  end
end