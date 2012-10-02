$ ->
  $("#reservation_equipment_autocomplete").on "railsAutocomplete.select", (evt, data) ->
    $(this).attr("value", "")

    $.ajax({
      url: "/admin/equipment/#{ data.item.id }/row?index=#{ countEquipment() }"
    }).complete (html) ->
      $("#reservation_equipment").append(html.responseText)
      $(".equipment_row[data-equipment-id=#{ data.item.id }] .remove_link").on "click", (evt, data) ->
        $(this).closest(".equipment_row").remove()

countEquipment = () ->
  $("#reservation_equipment > div").length
