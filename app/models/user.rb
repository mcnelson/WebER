class User < ActiveRecord::Base
  attr_accessible :active, :can_reserve, :notes, :pu_student_id, :punet, :strikes, :password, :password_confirmation, :email, :permission_level

  validates_uniqueness_of :pu_student_id, :punet, :email
  validates_presence_of :punet, :pu_student_id, :email, :permission_level
  validates_presence_of :password, :password_confirmation, on: :create

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  has_secure_password

  has_many :reservation, dependent: :restrict
  has_many :package, dependent: :restrict

  scope :active_users, where(active: true)

  after_initialize :create_permission_methods

  PERMISSION_LEVELS = [
    "student",
    "workstudy",
    "admin"
  ]

  def create_permission_methods
    PERMISSION_LEVELS.each_with_index do |pl, i|
      self.class.send :define_method, "#{pl}?" do
        (PERMISSION_LEVELS.index(permission_level) >= i)
      end
    end
  end
end
