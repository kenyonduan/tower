# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  initEventsSubscribe: () ->
    return if App.access_token.length < 5

    MessageBus.start()
    MessageBus.callbackInterval = 1000
    MessageBus.subscribe "/events", (json) ->
      # 把接收到的数据添加到 index 页面中
      $index_div = $('div[name=events_index_div]')
      $events_day_div = $index_div.find("div[events-day='#{yyyymmdd(json.created_at)}']")
      if $events_day_div == undefined || $events_day_div == null
        # 创建 day div
        $index_div.append(buildDayDiv(json))
      else
        $events_projectable_div = $events_day_div.find("div[events-projectable='#{json.projectable_type}_#{json.projectable_id}']")
        if $events_projectable_div == undefined || $events_projectable_div == null
          $events_day_div.append(buildProjectableDiv(json))
        else
          $events_home = $events_projectable_div.find("ul[name='events_home']")
          $($events_home.find('li').first).before(json.html)

  yyyymmdd = (date_str) ->
    date = new Date(Date.parse(date_str))
    yyyy = date.getFullYear().toString()
    mm = (date.getMonth() + 1).toString()
    dd = date.getDate().toString()
    yyyy + (mm[1] ? mm: "0" + mm[0]) + (dd[1] ? dd: "0" + dd[0])

  buildDayDiv = (json) ->
    "<div events-day='#{yyyymmdd(json.created_at)}'>" +
    "#{yyyymmdd(json.created_at)}" +
    buildProjectableDiv(json) +
    "</div>"

  buildProjectableDiv = (json) ->
    "<div events-projectable='#{json.projectable_type}_#{json.projectable_id}'" +
    "<a href='javascript:void(0)' target='_blank'>#{json.projectable.name}</a>" +
    "<ul name='events_home'></ul>"
    "<li>" +
    json.html +
    "</li>" +
    "</ul>" +
    "</div>"

  $(window).scroll ->
    if $(window).scrollTop() + $(window).height() == $(document).height()
      $index_div = $('div[name=events_index_div]')
      current_page_number = countCurrentPageNumber()
      if current_page_number == null
        $index_div.append('没有更多内容了.')
      else
        # 如何避免翻页加载后的数据重复?
        $.get('events/index', {team_id: App.current_team_id, page: current_page_number + 1}, (resp) ->
          $index_div.append(resp)
        )

  countCurrentPageNumber = () ->
    size = $('div[name=events_index_div]').find('ul[name=events_home] li').size
    size / 50 >= 1 ? size / 50: null


  # 初始化 MessageBus
  @initEventsSubscribe()
