namespace "weber.equipment.form", (exports) ->
  exports.init = ->
    $ ->
      $(".controls select").chosen {
        allow_single_deselect: true
      }

namespace "weber.equipment.show", (exports) ->
  exports.init = ->
    $ ->
      $('.equipment-photo').colorbox {
        href: $(@).parent('a').attr('href'),
        transition: "fade",
        speed: 150
      }

