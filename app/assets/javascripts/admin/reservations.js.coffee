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
            valid_er_hour_dates = $('#before_show_day_data').data('er_hour_days')
            [($.inArray($.datepicker.formatDate('dd/mm/yy', date), valid_er_hour_dates) != -1), "", "ER doesn't operate on this day"]

          onSelect: (datetext, inst) ->
            $(@).children('input').attr("value", datetext).trigger('select')

          dateFormat: "yy/mm/dd"
        }).each ->
          $(@).datepicker("setDate", $(@).children('input').attr("value"))

        $(".datepicker-input").on("select", exports.heartbeat)
      )
