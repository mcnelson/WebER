$ ->
  $(".auto-datepickers .simpleform-inline-datepicker").datepicker({
    onSelect: (datetext, inst) ->
      $(@).children('input').attr("value", datetext)
        .trigger ('select')

    dateFormat: "yy/mm/dd"
  })

  $(".auto-datepickers .simpleform-inline-datepicker").each ->
    $(@).datepicker("setDate", $(@).children('input').attr("value"))
