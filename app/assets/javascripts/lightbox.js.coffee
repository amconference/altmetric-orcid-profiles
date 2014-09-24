window.lightbox =
 
  show: (url) ->
    $lightbox_overlay = $("<div id='lightbox_overlay'/>")
    $lightbox_content = $("<div id='lightbox_content'/>")
    $lightbox_inner   = $("<div id='lightbox_inner'/>")
    $lightbox_iframe  = $("<iframe id='lightbox_iframe'/>")
    $lightbox_close_button = $("<a href='#' id='lightbox_close'></a>")

    $lightbox_inner.append $lightbox_iframe.attr("src", url)
    $lightbox_overlay.append( $lightbox_content.append( $lightbox_inner ) )
    $lightbox_content.append $lightbox_close_button
    $("body").append $lightbox_overlay
    
    $lightbox_close_button.on 'click', lightbox.hide
    $lightbox_overlay.on "click", lightbox.hide

    window.setTimeout ->
      $lightbox_overlay.addClass 'visible'
      $lightbox_content.addClass 'visible'
    , 100

  hide: ->
    $("#lightbox_overlay").removeClass "visible"
    $("#lightbox_content").removeClass "visible"
    window.setTimeout ->
      $("#lightbox_overlay").remove();
    , 333
