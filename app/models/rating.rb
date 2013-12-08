class Rating < ActiveRecord::Base
  scope :ordered, -> { order(:title) }
end
