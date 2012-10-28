$ ->
  $(".simpleform-inline-datepicker").datepicker({
    onSelect: (datetext, inst) ->
      $(@).children('input').attr("value", datetext)
    dateFormat: "yy/mm/dd"
  })

  $(".simpleform-inline-datepicker").each ->
    $(@).datepicker("setDate", $(@).children('input').attr("value"))
