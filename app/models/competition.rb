class Competition < ActiveRecord::Base
  validates :title, presence: true
  has_many :sections, dependent: :destroy
end
