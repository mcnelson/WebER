
Factory.define :user do |u|
  u.punet 'asdf1234'
  u.pu_student_id '0900991'
  u.email 'test@testerson.com'
  u.permission_level "student"
  u.password 'asdf'
  u.password_confirmation 'asdf'
end
