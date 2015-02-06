Field = require("../src/field").Field if module?.exports
class MineSweeper
  constructor: () ->
    Field = Field ? window.Field
    @field = new Field() ? new window.Field()
    #ゲームが始まっているかどうか
    @status = false
    @message = ""
  start:()->
    @message = ""
    @status = true
    @field.create()
  set:(row,col,mine)->
    @field.size = [parseInt(row),parseInt(col)]
    @field.mine = parseInt(mine)
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
    clear.call @ if @field.clear_check() and break_result
  end = ->
    @status = false
    @message = "game over"
    #console.log "gameover"
  clear = ->
    @status = false
    @message = "clear!"
    #console.log "clear"
  show:->
    view = " "
    for i in [0..@field.status.length-1]
      view += " "+@convert(i)
    for lines,index in @field.status
      view += "\n"+index + ""
      for block in lines
        if block.status == "normal"
          view += " ?"
        else if block.status == "checked"
          view += " F"
        else
          view += " "+block.val
    return view+"\n"+@message
  field_status:->
    return @field.status
  convert:(str)->
    #予め文字コードを取得しておく
    a_num = "a".charCodeAt(0)
    zero_num = "0".charCodeAt(0)
    result = ""
    #aは0に，0はaに変換する
    if parseInt(str) || str == 0
      #まずは26進数に変換
      num26 =  str.toString(26)
      #ひとけたずつ変換0->a,1->b...a->k...
      for num,index in num26
        digit = num26.length-index
        if num == "0" or parseInt num
          str_code = String(num).charCodeAt(0) - zero_num + a_num
        else
          str_code = num.charCodeAt(0) + 10
        str_code = str_code - 1 if digit != 1
        result += String.fromCharCode(str_code)
      return result
      #console.log str.toString(26)
      #console.log String(9).charCodeAt(0)
      #console.log "A".charCodeAt(0)
      num =  parseInt(str)
      result = String.fromCharCode(a_num + num )
      return result
    else
      #aを1としてあつかう#
      result = -1
      a_num = "a".charCodeAt(0)
      str_len = str.length
      for char,index in str
        digit = str_len - index #桁
        char_num = char.charCodeAt(0)+1-a_num
        result += char_num * Math.pow(26,digit-1)
        return result


if module?.exports
  module.exports.MineSweeper = MineSweeper
else
  @MineSweeper = MineSweeper

