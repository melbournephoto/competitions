# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :section do
    title 'EDI'
    max_file_size 1
    entry_limit 1
    max_height 1200
    max_width 1200
    competition_series
    competition
  end
end
