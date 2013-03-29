# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # chapter link
  current_chapter = null;
  $('#js-chapters a').on('click', ->
    current_chapter_p = $(current_chapter).parent()
    if(null != current_chapter)
      current_chapter_p.removeClass('active')
    current_chapter = @
    $(current_chapter).parent().addClass('active')

    $.get('/audio_books/parse.json', {url: @href}, (data)->
      console.log(data.message)
      if(data.state)
        $('#js-audio-control').attr('src', data.message);
    )
    false
  )
