# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  elm_results = $('#orcid-profile-results')
  elm_loading = $('#orcid-profile-results-loading')

  $('#orcid-submit-form').on 'submit', (e) ->
    e.preventDefault()
    window.location.href = "/#{ $('input[type=text]', this).val() }"

  $('.profile-content-wrapper').on 'click', 'article.work a:not(.doi)', (e) ->
    e.preventDefault()
    window.lightbox.show $(this).attr('href')

  content_wrapper = $('.profile-content-wrapper')
  loading_thingy = $('.profile-loading-indicator')
  if content_wrapper.length
    $.ajax
      action: 'get'
      url: "#{ window.location.href.replace('#','') }/content"
    .done (data,status,xhr) ->
      loading_thingy.hide()
      content_wrapper.html data
      window.load_graph()


  window.load_graph = ->

    # Graph
    colours =
      twitter: "#2F90B9"
      f1000: "#CB2D2D"
      policy: "#9f79f2"
      blogs: "#FFC200"
      news: "#B60000"
      peer_reviews: "#333"
      weibo: "#df931b"
      facebook: "#2445BD"
      googleplus: "#912470"
      q_a: "#888"
      reddit: "#B9DDEB"
      video: "#98C973"

    works_list = $('.works_list')
    raw_data = works_list.data('posts')
    data = {}
    for item in raw_data
      data[item.post_type] ||= []
      data[item.post_type].push item.posted_on
    window.plotTimes data, colours

    # Totals
    totals = $('#totals')
    for key, value of data
      elm = $("<div class='total_wrapper'><div class='total #{key.replace('&', '_')}'><span class='type'/><span class='value'/></div></div>")
      elm.find('.type').text key
      elm.find('.value').text value.length
      totals.append elm
