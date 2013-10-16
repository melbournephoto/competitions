class Competition < ActiveRecord::Base
  validates :title, presence: true
  validates :entries_open_at, presence: true
  validates :entries_close_at, presence: true
  validates :results_published_at, presence: true

  has_many :sections, dependent: :destroy
  has_many :entries, dependent: :destroy

  def open_for_entry?
    entries_open_at < Time.now && entries_close_at > Time.now
  end
end
