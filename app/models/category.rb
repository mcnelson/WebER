class Category < ActiveRecord::Base
  attr_accessible :title
  validates_presence_of :title

  has_many :equipment_bases, foreign_key: :category_id, class_name: "EquipmentBase"

  def humanize_type
    type.underscore.humanize.titlecase
  end
end
