namespace "weber.reservations.form", (exports) ->
  exports.init = ->
    $ ->
      exports.heartbeat()

  exports.heartbeat = (event) ->
    $(".reservation-form").submit().
      unbind("ajax:success").
      on("ajax:success", (evt) ->

        # Add/remove units
        $(document).
          unbind('nested:fieldAdded nested:fieldRemoved').
          on('nested:fieldAdded nested:fieldRemoved', exports.heartbeat)

        # Change any select
        $("select").unbind("change").on("change", exports.heartbeat).chosen()

        # Initialize datepicker
        $(".simpleform-inline-datepicker").datepicker({
          beforeShowDay: (date) ->
            [!(date.getDay() == 0 || date.getDay() == 6), "", "Not available on weekend"]

          onSelect: (datetext, inst) ->
            $(@).children('input').attr("value", datetext).trigger ('select')

          dateFormat: "yy/mm/dd"
        }).each ->
          $(@).datepicker("setDate", $(@).children('input').attr("value"))

        $(".datepicker-input").on("select", exports.heartbeat)
      )
