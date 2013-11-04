# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'ludivico@melbournephoto.org.au'
    password 'password'

    trait :admin do
      admin true
    end
  end
end
