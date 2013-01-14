namespace "weber.reservations.form", (exports) ->
  exports.init = ->
    $ ->
      exports.setupFormControls()

  # Makes datepickers, chosens
  exports.setupFormControls = ->
    $(document).
      unbind('nested:fieldAdded nested:fieldRemoved').
      on('nested:fieldAdded nested:fieldRemoved', exports.heartbeat)

    $("select").unbind("change").on("change", exports.heartbeat).chosen()

    $(".simpleform-inline-datepicker").
      datepicker({
        beforeShowDay: (date) ->
          [!(date.getDay() == 0 || date.getDay() == 6), "", "Not available on weekend"]
      })

    $(".datepicker-input").on "select", ->
      console.log("test")

  exports.heartbeat = (event) ->
    console.log("bo-boop")
    $(".reservation-form").submit().on "ajax:complete", exports.setupFormControls
