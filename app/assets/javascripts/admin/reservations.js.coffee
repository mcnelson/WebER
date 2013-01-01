namespace "weber.reservations.form", (exports) ->
  exports.form_valid = true

  exports.set_form_valid = (set) ->
    return if exports.form_valid == set

    exports.form_valid = set

    if set # Valid
      $('input[type=submit].btn').
        removeClass('btn-inverse').
        addClass('btn-primary')
      $('.pending-reservation-warning').hide()

    else # Invalid
      $('input[type=submit].btn').
        removeClass('btn-primary').
        addClass('btn-inverse')
      $('.pending-reservation-warning').show()

  exports.init = ->
    $ ->
      $(".controls select").chosen()
      $(".simpleform-inline-datepicker").datepicker("option", "beforeShowDay", (date) ->
        day = date.getDay()
        [!(day == 0 || day == 6), "", "Not available on weekend"]
      )
      $(".simpleform-inline-datepicker").on "select", unitRowsChanged

      $(".unit-row select")
        .chosen()
        .on("change", unitRowsChanged)

      $(document).on('nested:fieldAdded nested:fieldRemoved', (event) ->
        unitRowsChanged()

        $(event.field).find('select')
          .chosen()
          .on("change", unitRowsChanged)
      )

    unitRowsChanged = (event) ->
      # Put data-unit_id on the rows
      $(".unit-row").each (i, row) ->
        $(row).data("unit_id", $(row).find("select").attr("value"))

      check_unit_availability()

    check_unit_availability = ->
      # Build IDs into each array
      equipment = accessories = []
      unit_id_arrays(equipment, accessories)

      # Make the request
      $.ajax ({
        url: $(".reservation-form").data("check_unit_availability_path")
        data: {
          start_at: $("#reservation_starts_at").attr("value")
          end_at:   $("#reservation_ends_at").attr("value")
          equipment: equipment,
          accessories: accessories
        },
        success: (data, textStatus, jqXHR) ->
          if data.date_error
            ajax_error data.date_error

          else
            any_unavailable = false

            for unit in data.units
              target = $(".unit-row select[value=#{unit.id}]")

              # Set image
              $(target).closest(".unit-row").children(".unit-thumb").
                attr("src", unit.thumb)

              # Set class if unavilable
              if !unit.available
                $(target).closest(".control-group").addClass("error")
              else
                $(target).closest(".control-group").removeClass("error")

              # Set availability
              any_unavailable = true if !unit.available

            if any_unavailable
              ajax_error "One or more units you've selected isn't available in that date range."
            else
              ajax_error ""
      })


    ajax_error = (text) ->
      $(".form-errors").empty()
      exports.set_form_valid(!text.length)

      if text.length
        text = "<strong>There are currently problems with your reservation:</strong> #{text}"
        $(".form-errors").first().append(
          $('<div class="alert alert-error date-error"></div>').
            html(text).
            append( $('<button type="button" class="close" data-dismiss="alert">&times;</button>') )
        )

   # Get arrays of active unit IDs from rows
   unit_id_arrays = (equipment, accessories) ->
    $(".equipment-row:visible").each (i, row) ->
      equipment.push $(row).data("unit_id") if $(row).data("unit_id")

    $(".accessory-row:visible").each (i, row) ->
      accessories.push $(row).data("unit_id") if $(row).data("unit_id")
