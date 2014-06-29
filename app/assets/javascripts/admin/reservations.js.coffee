namespace "weber.reservations.form", (exports) ->
  exports.init = ->
    $ ->
      initFormControls()

      $form = $(".reservation-form")
      $form.on "ajax:send", ->
        toggleEnabled($form, false)

      $form.on "ajax:success", ->
        toggleEnabled($form, true)
        initFormControls()

      $(document).on "nested:fieldAdded", initFormControls

  initFormControls = (form) ->
    $("select").chosen()

    $(".simpleform-inline-datepicker").datepicker
      beforeShowDay: (date) ->
        valid_er_hour_dates = $('#before_show_day_data').data('er_hour_days')
        [($.inArray($.datepicker.formatDate('dd/mm/yy', date), valid_er_hour_dates) != -1), "", "ER doesn't operate on this day"]

      onSelect: (datetext, inst) ->
        $(@).children('input').attr("value", datetext).trigger('select')

      dateFormat: "yy/mm/dd"

    .each ->
      $(@).datepicker("setDate", $(@).children('input').attr("value"))

  toggleEnabled = ($form, toggle) ->
    $form.css({opacity: (if toggle then 1 else .2)})

    if toggle
      $('.loader').css(display: 'none')
      $form.find(":input").removeAttr("disabled")
    else
      $('.loader').css(display: 'block')
      $form.find(":input").attr("disabled", "disabled")
