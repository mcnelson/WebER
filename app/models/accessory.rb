class Accessory < Unit
  belongs_to :accessory_category, foreign_key: :category_id

  def name
    accessory_category.title.singularize if accessory_category.present?
  end
end
