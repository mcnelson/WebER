namespace "weber.reservations.form", (exports) ->
  exports.form_valid = true

  exports.set_form_valid = (set) ->
    #window.namespace.form_valid

  exports.init = ->
    $ ->
      $(".controls select").chosen()

      $(document).on('nested:fieldAdded', (evt) ->
        # TODO: Trigger unit rows changed on field added & changed.
        $(evt.field).find('select')
          .chosen()
          .on("change", unitRowsChanged)
      )

    unitRowsChanged = (evt) ->
      console.log("Equipment has been changed")
      check_unit_availability()

    check_unit_availability = ->
      equipment = []
      accessories = []

      $(".reservation-form .reservation-equipment-rows select").each (i, item) ->
        equipment.push $(item).attr("value") if $(item).attr("value")

      $(".reservation-form .reservation-accessory-rows select").each (i, item) ->
        accessories.push $(item).attr("value") if $(item).attr("value")

      $.ajax ({
        url: $(".reservation-form").data("check_unit_availability_path")
        data: {
          start_at: $("#reservation_starts_at").attr("value")
          end_at:   $("#reservation_ends_at").attr("value")
          equipment: equipment,
          accessories: accessories
        },
        success: (data, textStatus, jqXHR) ->
          console.log(data)
      })

      $(".simpleform-inline-datepicker").on "select", (evt, data) ->
        console.log("datepicker changed")

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
