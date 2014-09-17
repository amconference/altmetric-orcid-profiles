# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  elm_results = $('#orcid-profile-results')
  elm_loading = $('#orcid-profile-results-loading')

  $('#orcid-submit-form').on 'submit', (e) ->
    e.preventDefault()
    $.ajax
      action: 'get'
      url: "/#{ $('input[type=text]', this).val() }"
      beforeSend: ->
        elm_results.hide()
        elm_loading.show()
    .done (data, status, xhr) ->
        elm_loading.hide()
        elm_results.html data
        elm_results.show() 
