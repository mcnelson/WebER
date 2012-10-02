$ ->
  $("#reservation_equipment_autocomplete").on "railsAutocomplete.select", (evt, data) ->
    $(@).attr("value", "")

    $.ajax({
      url: $(@).data("ajax-url"),
      data: { id: data.item.id },
      dataType: "json"
    }).success (data) ->
      $("#reservation_equipment").append(
        $(data.row_html).first(".remove_link").on "click", (evt, data) ->
          $(@).closest(".equipment_row").remove()
      )

countEquipment = () ->
  $("#reservation_equipment > div").length
