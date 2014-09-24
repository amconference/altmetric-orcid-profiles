# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  elm_results = $('#orcid-profile-results')
  elm_loading = $('#orcid-profile-results-loading')

  $('#orcid-submit-form').on 'submit', (e) ->
    e.preventDefault()
    window.location.href = "/#{ $('input[type=text]', this).val() }"

  $('article.work a:not(.doi)').on 'click', (e) ->
    e.preventDefault()
    window.lightbox.show $(this).attr('href')

  content_wrapper = $('.profile-content-wrapper')
  loading_thingy = $('.profile-loading-indicator')
  if content_wrapper.length
    $.ajax
      action: 'get'
      url: "#{ window.location.href }/content"
    .done (data,status,xhr) ->
      loading_thingy.hide()
      content_wrapper.html data
