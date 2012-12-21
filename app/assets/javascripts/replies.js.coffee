# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  new_reply_module = ->
    wrapper = $('#new_reply_wrapper').html()
    $('#reply_comment_id', $(wrapper)).val($(@).attr('data-comment-id'))
    comment_reply = $(@).parent().parent().next()
    comment_reply.html(wrapper)
    comment_reply.toggle()

  create_reply_after = (html)->
    $(@).parent().parent().next().html(html)

  # js-comment-reply 评论，回复
  $('#js_paginate_result').on 'click', '.js-comment-reply-link', new_reply_module

  # js-form-reply
  $('.js-form-reply').form({ live: true, after: create_reply_after })


