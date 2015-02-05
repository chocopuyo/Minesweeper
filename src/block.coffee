class Block
  constructor: (val) ->
    #status => ["breaked","normal","checked"]
    @status = "normal"
    @val = val
  break:()->
    return true if @status == "checked" || @status == "breaked"
    @status = "breaked"
    if @val == "x"
      return false
    else if @val == 0
      return "chain"
    else
      return true
  check:()->
    if @status == "normal"
      @status = "checked"
    else
      @status = "normal"

if module?.exports
  module.exports.Block =Block
else
  @Block =Block
