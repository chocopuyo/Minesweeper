Block = require("../src/block").Block
class Field
  constructor: () ->
    @size = [5,5]
    @mine = 5
    @status = []
  #フィールドを生成する
  create:()->
    field_num = @size[0]*@size[1]
    mine_pos = rand_mine.call @,@mine,field_num
    for i in [0..@size[0]-1]
      for j in [0..@size[1]-1]
        @status[i] = [] if @status[i] == undefined
        #マスにブロックを設置する
        if mine_pos[i][j] == "x"
          @status[i][j] = new Block("x")
        else
          around_mine = calc_around_mine(i,j,mine_pos)
          @status[i][j] = new Block(around_mine)
  #マスを壊す
  break:(x,y)->
    return @status[x][y].break()
  #マスに旗を立てる
  check:(x,y)->
    return @status[x][y].check()
  #クリア判定
  clear_check :()->
    breaked_block_num = 0
    for i in [0..@size[0]-1]
      for j in [0..@size[1]-1]
        breaked_block_num += 1 if @status[i][j].status == "breaked"
    if breaked_block_num+@mine >= @size[0]*@size[1]
      return true
    else
      return false

  #ランダムに地雷を発生させる
  rand_mine = (mine_num,field_num)->
    temp_arr = []
    result = []
    #とりあえず1次元配列で地雷を生成
    while temp_arr.length < mine_num
      rand_num = parseInt(Math.random()*25)
      if temp_arr.indexOf(rand_num) == -1
        temp_arr.push rand_num
    #一次元配列で生成した地雷を二次元配列に変更する
    for i in [0..@size[0]-1]
      for j in [0..@size[1]-1]
        result[i] = [] if result[i] == undefined
        if temp_arr.indexOf(i*@size[0]+j+1) != -1
          result[i][j] = "x"
        else
          result[i][j] = 0
    return result
  #スペースの周り8マスの地雷を数える
  calc_around_mine = (i,j,mine_pos)->
    sum_result = 0
    for ti in [-1..1]
      continue if mine_pos[i+ti] == undefined
      for tj in [-1..1]
        sum_result += 1 if mine_pos[i+ti][j+tj] == "x"
    return sum_result


if module?.exports
  module.exports.Field = Field
else
  @Field = Field
