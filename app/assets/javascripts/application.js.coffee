#= require jquery
#= require jquery_ujs
#= require_tree .

$ ->
  $('.SheetForm-textarea').on 'click', ->
    $(this).css(backgroundImage: 'none')

  $('.SheetForm-textarea').height($('.SheetPreview').height())
  $('.SheetResult-button').on 'click', ->
    if $('.SheetForm-textareaOuter').css('display') is 'none'
      $('.SheetPreview').hide()
      $('.SheetForm-textareaOuter').fadeIn()
      $('.SheetForm-textarea').focus().select()
    else
      $('.SheetPreview').fadeIn()
      $('.SheetForm-textareaOuter').hide()
