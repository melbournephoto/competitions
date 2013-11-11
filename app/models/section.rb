class Section < ActiveRecord::Base
  belongs_to :competition
  belongs_to :competition_series

  validates :competition_id, presence: true
  validates :competition_series_id, presence: true
  validates :title, presence: true
  validates :max_file_size, presence: true, numericality: true
  validates :entry_limit, presence: true, numericality: true
  validates :max_height, presence: true, numericality: true
  validates :max_width, presence: true, numericality: true
end
