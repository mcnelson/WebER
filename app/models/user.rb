class User < ActiveRecord::Base
  PERMISSION_LEVELS = %w(student workstudy admin)

  validates_uniqueness_of :pu_student_id, :punet, :email
  validates_presence_of :punet, :pu_student_id, :email, :permission_level
  validates_presence_of :password, :password_confirmation, on: :create

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  has_secure_password

  has_many :reservations, dependent: :restrict
  has_many :packages, dependent: :restrict

  scope :active_users, where(active: true)

  PERMISSION_LEVELS.each do |l|
    define_method("#{l}?") { permission_level == l }
  end
end
