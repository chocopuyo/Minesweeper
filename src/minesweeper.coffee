Field = require("../src/field").Field
class MineSweeper
  constructor: () ->
    @field = new Field()
    #ゲームが始まっているかどうか
    @status = false
  start:()->
    @status = true
    @field.create()
  set:(row,col,mine)->
    @field.size = [row,col]
    @field.mine = mine
  action:(x,y,action_name)->
    return false if not @status
    break_result = true
    switch action_name
      when "break"
        break_result = @field.break(x,y)
      when "check"
        @field.check(x,y)
      else
        console.log "not defined action"
    #もし破壊したところが地雷なら
    end.call @ if not break_result
    clear.call @ if @field.clear_check()
  end = ->
    @status = false
    #console.log "gameover"
  clear = ->
    @status = false
    #console.log "clear"


if module?.exports
  module.exports.MineSweeper = MineSweeper
else
  @MineSweeper = MineSweeper

