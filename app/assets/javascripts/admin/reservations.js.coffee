$ ->
  $("#reservation_equipment_autocomplete").on "railsAutocomplete.select", (evt, data) ->
    $(this).attr("value", "")

    $.ajax({
      url: "?add_equipment=1&idx=#{ countEquipment() }&equipment_id=#{ data.item.id }"
    }).complete (html) ->
      $("#reservation_equipment").append(html.responseText)

countEquipment = () ->
  $("#reservation_equipment > div").length
