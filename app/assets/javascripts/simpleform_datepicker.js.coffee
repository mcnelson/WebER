$ ->
  $(".simpleform-inline-datepicker").datepicker {
    onSelect: (datetext, inst) ->
      $(this).children('input').attr("value", datetext)
  }
