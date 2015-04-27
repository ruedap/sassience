#= require jquery
#= require jquery_ujs
#= require_tree .

$ ->
  $('.SheetForm-textarea').on 'click', ->
    $(this).css(backgroundImage: 'none')

  $('.SheetForm-textarea').height($('.SheetPreview').height())
  $('.SheetResult-button').on 'click', ->
    if $('.SheetForm-textarea').css('display') is 'none'
      $('.SheetPreview').hide()
      $('.SheetForm-textarea').fadeIn()
      $('.SheetForm-textarea').focus().select()
    else
      $('.SheetPreview').fadeIn()
      $('.SheetForm-textarea').hide()
