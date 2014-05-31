class User < ActiveRecord::Base
  PERMISSION_LEVELS = %w(student workstudy admin)

  has_secure_password

  validates :pu_student_id, :punet, :email, uniqueness: true
  validates :punet, :pu_student_id, :email, :permission_level, :password, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :password_confirmation, on: :create, presence: true

  has_many :reservations, dependent: :restrict_with_error
  has_many :packages, dependent: :restrict_with_error

  scope :active_users, where(active: true)

  PERMISSION_LEVELS.each do |l|
    define_method("#{l}?") { permission_level == l }
  end
end
