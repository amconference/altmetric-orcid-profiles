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
      window.load_graph()


  window.load_graph = ->
    works_list = $('.works_list')
    raw_data = works_list.data('posts')
    data = {}
    for item in raw_data
      data[item.post_type] ||= []
      data[item.post_type].push item.posted_on
    console.log data
    window.plotTimes data
