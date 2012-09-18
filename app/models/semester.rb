class Semester < ActiveRecord::Base
  attr_accessible :ends_at, :name, :starts_at
end
