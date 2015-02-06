shell = require('shell')
app = new shell( { chdir: __dirname } )
MineSweeper = require("./src/minesweeper").MineSweeper

#データ保存用変数
ms = new MineSweeper()
#シェルの環境設定
app.configure(()->
    app.use(shell.history({
        shell: app
    }))
    app.use(shell.completer({
        shell: app
    }))
    app.use(shell.router({
        shell: app
    }))
    app.use(shell.help({
        shell: app,
        introduction: true
    }))
)
#コマンド定義
app.cmd('start', 'game start', (req, res, next)->
  ms.start()
  console.log "good luck"
  console.log ms.show()
  res.prompt()
)
app.cmd('set :x :y :mine', 'set game config', (req, res, next)->
  arg = req.params
  ms.set(arg.x,arg.y,arg.mine)
  console.log("set complete")
  res.prompt()
)
app.cmd('break :x :y', 'break block', (req, res, next)->
  arg = req.params
  x = ms.convert(arg.x)
  ms.action(req.params.y,x,"break")
  console.log ms.show()
  res.prompt()
)

app.cmd('check :x :y', 'break block', (req, res, next)->
  arg = req.params
  x = ms.convert(arg.x)
  ms.action(req.params.y,x,"check")
  console.log ms.show()
  res.prompt()
)
