namespace "weber.reservations.form", (exports) ->
  exports.init = ->
    $ ->
      setupFormControls()
      $("select").on "change", heartbeat
      $(document).on 'nested:fieldAdded nested:fieldRemoved', heartbeat

    # Makes datepickers, chosens
    setupFormControls = ->
      $(".controls select").chosen()

      $(".simpleform-inline-datepicker").
        datepicker().
        datepicker("option", "beforeShowDay", (date) ->
          [!(date.getDay() == 0 || date.getDay() == 6), "", "Not available on weekend"]
        )

      $(".simpleform-inline-datepicker").on "select", heartbeat

    heartbeat = (event) ->
      console.log("bo-boop")
      $(".reservation-form").submit().on "ajax:complete", setupFormControls
