namespace "weber.reservations.form", (exports) ->
  exports.form_valid = true

  exports.set_form_valid = (set) ->
    return if exports.form_valid == set

    exports.form_valid = set
    $('.form-actions input[type=submit]').attr("disabled", !set)

  exports.init = ->
    $ ->
      $(".controls select").chosen()
      $(".simpleform-inline-datepicker").datepicker("option", "beforeShowDay", (date) ->
        day = date.getDay()
        [!(day == 0 || day == 6), "", "Not available on weekend"]
      )
      $(".simpleform-inline-datepicker").on "select", unitRowsChanged

      $(document).on('nested:fieldAdded', (event) ->
        unitRowsChanged()

        $(event.field).find('select')
          .chosen()
          .on("change", unitRowsChanged)
      )

    unitRowsChanged = (event) ->
      check_unit_availability()

    check_unit_availability = ->
      # Build IDs into each array
      equipment = []
      accessories = []

      $(".reservation-form .reservation-equipment-rows select").each (i, item) ->
        equipment.push $(item).attr("value") if $(item).attr("value")

      $(".reservation-form .reservation-accessory-rows select").each (i, item) ->
        accessories.push $(item).attr("value") if $(item).attr("value")

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

            for unit in data
              target = $(".unit-row select[value=#{unit.id}]")

              # Set image
              $(target).closest(".unit-row").children(".unit-thumb").
                attr("src", unit.thumb)

              # Set class if unavilable
              if !data.available
                $(target).addClass("unit-unavailable")
              else
                $(target).removeClass("unit-unavailable")

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
        text = "<strong>Your reservation is currently invalid and you cannot proceed:</strong> #{text}"
        $(".form-errors").first().append(
          $('<div class="alert alert-error date-error"></div>').
            html(text).
            append( $('<button type="button" class="close" data-dismiss="alert">&times;</button>') )
        )

    # $(".tabs").tabs()

    # # On change reservation date

    #   # Refresh tabbox
    #   $('.tabs').tabs("destroy")

    #   # Update hrefs
    #   $('.tabs ul li a').each ->
    #     s = $(@)
    #       .attr("href")
    #       .split('?')

    #     p = $.parseParams(s[1])

    #     p.start_at = $('[name="reservation[starts_at]"]').attr("value")
    #     p.end_at = $('[name="reservation[ends_at]"]').attr("value")

    #     $(@).attr("href", "#{ s[0] }?#{ $.param(p) }")

    #   $('.tabs').tabs()
