class CompetitionSeries < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  has_many :competition_series_grades, dependent: :destroy

  has_many :grades

  validates :title, presence: true
end
