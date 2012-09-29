class User < ActiveRecord::Base
  attr_accessible :active, :can_reserve, :notes, :pu_student_id, :punet, :strikes, :password, :password_confirmation, :email

  validates_uniqueness_of :pu_student_id, :punet, :email
  validates_presence_of :punet, :pu_student_id, :password, :password_confirmation, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  has_secure_password

  has_many :reservation
end
