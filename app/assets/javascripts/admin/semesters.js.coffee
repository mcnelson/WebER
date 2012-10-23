
namespace "weber.semesters.new", (exports) ->
  exports.init = ->
    $ ->
      $(".controls select").chosen {
        allow_single_deselect: true
      }
