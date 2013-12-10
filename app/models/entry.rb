class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition
  belongs_to :section
  belongs_to :rating
  belongs_to :grade

  serialize :exif

  mount_uploader :photo, PhotoUploader

  validates :photo, presence: true
  validates :section_id, presence: true
  validates :grade_id, presence: true
  validate :file

  before_create :set_order

  scope :ordered, -> { includes(:grade).order('grades.order', :order) }
  scope :not_rated, -> { where(rating_id: nil) }

  def title
    read_attribute(:title).blank? ? 'Untitled' : read_attribute(:title)
  end

  def section_entry_count_for_user
    entries = Entry.where(user: user, section: section)
    unless self.new_record?
      entries = entries.where('entries.id <> ?', self.id)
    end
    entries.count
  end

  private
  def file
    return if section.nil? || photo.nil?

    self.photo_file_size = photo.size

    if photo.path
      img = ::Magick::Image::read(photo.path).first
      self.photo_width = img.columns
      self.photo_height = img.rows
      self.exif = Hash[img.get_exif_by_entry]
    end


    if photo_file_size > section.max_file_size.megabytes
      errors.add(:photo, "The maximum upload is #{section.max_file_size}mb")
    end

    if section_entry_count_for_user >= section.entry_limit
      errors.add(:section_id, "Maximum of #{section.entry_limit} #{"entry".pluralize(section.entry_limit)} permitted in section '#{section.title}'")
    end

    if photo_width > section.max_width
      errors.add(:photo, "The maximum width is #{section.max_width}px")
    end

    if photo_height > section.max_height
      errors.add(:photo, "The maximum height is #{section.max_height}px")
    end
  end

  def set_order
    self.order = Random.new.rand(2147483647)
  end
end
