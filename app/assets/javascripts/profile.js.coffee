# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  elm_results = $('#orcid-profile-results')
  elm_loading = $('#orcid-profile-results-loading')

  $('#orcid-submit-form').on 'submit', (e) ->
    e.preventDefault()
    window.location.href = "/#{ $('input[type=text]', this).val() }"
