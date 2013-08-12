class Section < ActiveRecord::Base
  belongs_to :competition

  validates :max_file_size, presence: true, numericality: true
  validates :entry_limit, presence: true, numericality: true
  validates :max_height, presence: true, numericality: true
  validates :max_width, presence: true, numericality: true
end
