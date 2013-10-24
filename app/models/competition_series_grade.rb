class CompetitionSeriesGrade < ActiveRecord::Base
  belongs_to :competition_series
  belongs_to :grade
  belongs_to :user

  validates :competition_series_id, presence: true
  validates :grade_id, presence: true
  validates :user_id, presence: true
end
