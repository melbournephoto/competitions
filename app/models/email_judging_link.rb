class EmailJudgingLink
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :email

  validates :email, presence: true

  def persisted?
    false
  end
end