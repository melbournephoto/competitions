class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries, dependent: :destroy
  has_many :competition_series_grades

  validates :first_name, presence: true
  validates :last_name, presence: true

  accepts_nested_attributes_for :competition_series_grades

  scope :ordered, -> { order(:last_name, :first_name)}

  def name
    [first_name, last_name].join(' ')
  end
end
