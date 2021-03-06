namespace "weber.equipment.form", (exports) ->
  exports.init = ->
    $ ->
      $(".controls select").chosen {
        allow_single_deselect: true
      }

      # Chosenify upon adding dependency
      $(document).on "nested:fieldAdded", (evt) ->
        $(".controls select").chosen {
          allow_single_deselect: true
        }

      $('.controls textarea').css('overflow', 'hidden').autogrow()

namespace "weber.equipment.show", (exports) ->
  exports.init = ->
    $ ->
      $(".equipment-photo").colorbox {
        href: $(".equipment-photo").parent('a').attr('href'),
        transition: "fade",
        speed: 150
      }

namespace "weber.equipment.index", (exports) ->
  exports.init = ->
    $ ->
      $(".equipment-filters select").chosen({
        allow_single_deselect: true
      }).on("change", (evt) ->
        $(@).parents('form').submit()
      )
