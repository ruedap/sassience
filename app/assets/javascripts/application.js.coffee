#= require jquery
#= require jquery_ujs
#= require_tree .

$ ->
  $('.SheetForm-textarea').on 'click', ->
    $(this).css(backgroundImage: 'none')
