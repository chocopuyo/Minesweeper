chai = require 'chai'
expect = chai.expect
chai.should()
# add should method to Object.prototype

MineSweeper = require("../src/minesweeper").MineSweeper

describe 'MineSweeper',->
  ms = null
  before ->
    ms = new MineSweeper()
  it "create field (5x5 and 5mine)",->
    ms.start()
    expect(ms.field.status.length).be.equal(5)
    expect(ms.field.status[0].length).be.equal(5)
    expect(ms.field.status[0][0].constructor.name).be.equal("Block")
  it "create field (7x6 and 10mine)",->
    ms.set(7,6,10)
    ms.start()
    expect(ms.field.status.length).be.equal(7)
    expect(ms.field.status[0].length).be.equal(6)
    expect(ms.field.status[0][0].constructor.name).be.equal("Block")
  it "break block", ->
    ms.set(5,5,5)
    ms.start()
    ms.action(0,0,"break")
    block = ms.field.status[0][0]
    expect(block.status).be.equal("breaked")
  it "check block",->
    ms.set(5,5,5)
    ms.start()
    ms.action(0,0,"check")
    block = ms.field.status[0][0]
    expect(block.status).be.equal("checked")
  it "cannot break check block",->
    ms.set(5,5,5)
    ms.start()
    ms.action(0,0,"check")
    block = ms.field.status[0][0]
    expect(block.status).be.equal("checked")
    ms.action(0,0,"break")
    block = ms.field.status[0][0]
    expect(block.status).be.equal("checked")
  it "repeat check block and release",->
    ms.set(5,5,5)
    ms.start()
    ms.action(0,0,"check")
    block = ms.field.status[0][0]
    expect(block.status).be.equal("checked")
    ms.action(0,0,"check")
    expect(block.status).be.equal("normal")
  it "break chain & clear",->
    ms.set(2,2,0)
    ms.start()
    ms.action(0,0,"break")
    expect(ms.status).be.equal(false)
  ###
  it "expects true is true like Jasmine", ->
    expect(true).be.true
  it "should be true like RSpec", ->
    true.should.be.true

  it "should rutern item string with toString",->
    t.toString().should.equal("foo bar")


  it "should return true with #did after done", ->
    t.did.should.not.be.true
    t.done()
    t.did.should.be.true
  ###
