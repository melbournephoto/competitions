class Competition < ActiveRecord::Base
  validates :title, presence: true
end
