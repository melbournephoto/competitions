class Grade < ActiveRecord::Base
  belongs_to :competition_series
  has_many :competition_series_grades
  has_many :entries

  validates :title, presence: true
  validates :competition_series_id, presence: true

  scope :ordered, -> { order(:order) }
end
