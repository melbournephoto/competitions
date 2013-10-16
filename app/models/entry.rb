class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition
  belongs_to :section
  belongs_to :rating

  mount_uploader :photo, PhotoUploader

  validates :photo, presence: true
  validates :section_id, presence: true
  validate :file

  def file
    return if section.nil? || photo.nil?
    if photo.size > section.max_file_size.megabytes
      errors.add(:photo, "The maximum upload is #{section.max_file_size}mb")
    end

    if section_entry_count_for_user >= section.entry_limit
      errors.add(:section_id, "Maximum of #{section.entry_limit} #{"entry".pluralize(section.entry_limit)} permitted in section '#{section.title}'")
    end
  end

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
end
