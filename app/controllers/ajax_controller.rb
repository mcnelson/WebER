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

    json = { units: [], error_html: "", needed_accessories: [], suggested_accessories: [] }

    current_reservation_id  = params[:reservation_id].to_i # If editing
    start_at                = params[:start_at].to_date
    end_at                  = params[:end_at].to_date
    length_in_seconds       = (start_at.to_i - end_at.to_i).abs
    equipment_ids           = params[:equipment].to_a.map!(&:to_i)
    accessory_ids           = params[:accessories].to_a.map!(&:to_i)
    unit_ids                = equipment_ids + accessory_ids

    if unit_ids.present?
      if start_at >= end_at
        @errors << "The check-out date must be before the check-in date."
        json[:error_html] = render_to_string "form_errors", locals: { object: }
      elsif start_at < 3.days.from_now
        json[:error_html] = render_to_string "form_errors", locals: { object: }
        @errors << "The check-out date must be "
      else
        unit_ids.each do |unit_id|
          if (unit = Unit.find(unit_id))
            overlapping_reservations = unit.
              in_reservations_in_range_exclusive(start_at, end_at).
              where("reservations.id != ?", current_reservation_id)

            maxperiod_exceeded = length_in_seconds > unit.max_reservation_period

            json[:units] << {
              id:         unit.id,
              error:      overlapping_reservations.any? || maxperiod_exceeded,
              available:  !overlapping_reservations.any?,
              loo_long:   maxperiod_exceeded,
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
