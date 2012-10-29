$ ->
  $(".controls select").chosen()
  $(".tabs").tabs()

  # On change reservation date
  $(".simpleform-inline-datepicker").on("select", (evt, data) ->

    # Refresh tabbox
    $('.tabs').tabs("destroy")

    # Update hrefs
    $('.tabs ul li a').each ->
      s = $(@)
        .attr("href")
        .split('?')

      p = $.parseParams(s[1])

      p.start_at = $('[name="reservation[starts_at]"]').attr("value")
      p.end_at = $('[name="reservation[ends_at]"]').attr("value")

      $(@).attr("href", "#{ s[0] }?#{ $.param(p) }")

    $('.tabs').tabs()
  )
