class AjaxController < ApplicationController
  def reservation_tabbox
    return if params[:start_at].blank? || params[:end_at].blank?

    @available = []
    @unavailable = []

    @category = Category.find params[:category_id]
    @equipment = @category.equipment.each do |equipment|
      if equipment.available_in_range?(params[:start_at], params[:end_at])
        @available << equipment
      else
        @unavailable << equipment
      end
    end

    render partial: "reservation_tabbox"
  end

  def check_unit_availability
    return raise "Missing date parameters" if params_missing_any? [:start_at, :end_at]
    json = { units: [], date_error: "", needed_accessories: [], suggested_accessories: [] }

    start_at = params[:start_at].to_date
    end_at = params[:end_at].to_date
    equipment_ids = params[:equipment].to_a.map!(&:to_i)
    accessory_ids = params[:accessories].to_a.map!(&:to_i)
    unit_ids = equipment_ids + accessory_ids

    if unit_ids.present?
      if start_at > end_at
        json[:date_error] = "The start date is after the end date."
      else
        unit_ids.each do |unit_id|
          if (unit = Unit.find(unit_id))
            json[:units] << {
              id:         unit.id,
              available:  unit.in_reservations_in_range_exclusive(start_at, end_at).any?,
              thumb:      unit.photo.url(:forty),
              medium:     unit.photo.url(:twosixty)
            }
          end
        end

        # Iterate equipment and find accessory it depends on in current reservation. If
        # missing, add to
        checked_accessories = accessory_ids.clone
        equipment_ids.each do |equipment_id|
          equipment = Equipment.find(equipment_id)
          equipment.accessory_dependencies.each do |accessory_dependency|

            accessory_dependency.accessory_category.accessories.each do |accessory|
              if checked_accessories.include? accessory.id
                checked_accessories.delete(accessory.id)

              elsif accessory_dependency.optional?
                json[:suggested_accessories] << { unit_id: equipment_id, accessory: accessory }

              else
                json[:needed_accessories] << { unit_id: equipment_id, accessory: accessory }
              end
            end
          end
        end
      end
    end

    respond_to do |fmt|
      fmt.json { render json: json }
    end
  end

  def equipment_dependencies

  end

  private

  def params_missing_any?(array)
    array.each { |v| return true unless params.has_key? v }

    false
  end
end
