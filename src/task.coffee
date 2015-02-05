root = exports ? window
class root.Task
  did: false

  constructor: (item) ->
    @item = item

  toString: ->
    @item

  done: ->
    @did = true
