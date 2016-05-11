# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window).bind 'page:change', ->
  $(".project-btn").click (e) ->
    pid = $(this).attr("value")
    $("#projectModalBody").html  $("#project#{pid}").html()
