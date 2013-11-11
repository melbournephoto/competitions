# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :competition do
    title 'Febuary 2014'
    entries_open_at 1.month.ago
    entries_close_at 1.month.from_now
    results_published_at 2.months.from_now
  end
end
