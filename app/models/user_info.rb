class UserInfo < ActiveRecord::Base
  attr_accessible :active, :can_reserve, :notes, :pu_student_id, :punet, :strikes, :password, :password_confirmation
  validates_uniqueness_of :pu_student_id, :punet

  has_secure_password
end
