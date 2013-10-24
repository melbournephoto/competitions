# Read about factories at https://github.com/thoughtbot/factory_girl

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :entry do
  	title 'Entry'
    section
    grade
    user
    photo { fixture_file_upload(Rails.root.join('spec/fixtures/red_umbrella.jpg')) }
  end
end
