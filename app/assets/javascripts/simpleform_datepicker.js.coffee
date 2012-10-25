$ ->
  $(".simpleform-inline-datepicker").datepicker({
    onSelect: (datetext, inst) ->
      $(@).children('input').attr("value", datetext)
    dateFormat: "yy/mm/dd"
  })

  $(".simpleform-inline-datepicker").each (d) ->
    d.datepicker("setDate", $(@).children('input').attr("value"))
