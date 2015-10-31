# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initEventsSubscribe: () ->
  return if App.access_token.length < 5

  MessageBus.start()
  MessageBus.callbackInterval = 1000
  MessageBus.subscribe "/events", (json) ->
    if json.count > 0

      '' # TODO 把接收到的数据添加到 index 页面中

# TODO 翻页功能的实现(触底加载)
@initEventsSubscribe()
