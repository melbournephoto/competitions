require 'zip'

class Competition < ActiveRecord::Base
  validates :title, presence: true
  validates :entries_open_at, presence: true
  validates :entries_close_at, presence: true
  validates :results_published_at, presence: true
  validates :judge_key, presence: true, uniqueness: true

  has_many :sections, dependent: :destroy
  has_many :entries, dependent: :destroy

  scope :ordered, -> { order('entries_close_at desc') }
  scope :open, -> { ordered.where('entries_close_at > ?', Time.now) }
  scope :closed, -> { where('entries_close_at < ?', Time.now) }
  scope :entered_by, ->(user) { ordered.closed.joins(:entries).where('entries.user_id=?', user.id).group(:competition_id) }

  before_validation :set_judge_key

  def open_for_entry?
    entries_open_at < Time.now && entries_close_at > Time.now
  end

  def results_published?
    results_published_at < Time.now
  end

  private
  def set_judge_key
    return unless self.judge_key.blank?

    self.judge_key = SecureRandom.hex
  end

end
