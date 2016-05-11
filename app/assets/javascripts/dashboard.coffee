# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window).bind 'page:change', ->
  $('.datepicker').datepicker
    format: 'yyyy-mm-dd'
    autoclose: true
    todayHighlight: true
    language: 'zh-CN'
  if $('#weather').length > 0
    $.get '/dashboard/weather', (data) ->
      heading = $('#weather .heading')
      heading.attr('class', 'wi wi-'+data.icon+" heading")
      $('#weather .num').text(data.num)
      $('#weather .hint').text(data.hint)
