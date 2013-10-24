class Grade < ActiveRecord::Base
  has_many :competition_series_grades

  validates :title, presence: true
end
