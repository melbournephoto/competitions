class CompetitionSeries < ActiveRecord::Base
  has_many :competitions, dependent: :destroy
  has_many :competition_series_grades, dependent: :destroy

  has_many :grades, through: :competition_series_grades
end
