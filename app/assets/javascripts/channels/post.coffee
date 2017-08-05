jQuery ->
  if `$("#input_Text").data("postId")`
    App.post = App.cable.subscriptions.create {channel: "PostChannel", id: `$("#input_Text").data("postId")`},
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        $('#comments').append data['comment']

      speak: (comment) ->
        @perform 'speak', comment: comment, post: `$("#input_Text").data("postId")`, user: `$("#input_Text").data("userId")`

    $(document).on 'keypress', '[data-behavior~=post_speaker]', (event) ->
      if event.keyCode is 13
        if event.target.value != ''
          App.post.speak event.target.value
          event.target.value = ''
          event.preventDefault()
