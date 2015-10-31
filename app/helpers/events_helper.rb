module EventsHelper
  # 对 event 进行分组(日期、Projectable)
  def events_group(events)
    events.group_by { |event| [event.created_at.to_date, event.projectable] }
  end

  def event_day_format(date)
    now = Time.now
    case date_format(date)
      when date_format(now)
        '今'
      when date_format(now - 1.day)
        '昨'
      else
        date_format(date)
    end
  end

  def date_format(date)
    date.respond_to?(:strftime) ? date.strftime('%Y-%m-%d') : date.to_s
  end

  def projectable_url(projectable)
    url_helpers.send("#{projectable.class.to_s.downcase}_url", projectable)
  end

  def projectable_key(projectable)
    "#{projectable.class.to_s.downcase}_#{projectable.id}"
  end

  def target_name(target)
    target.try(:name) || target.try(:title) || ''
  end

  def target_url(target)
    method, params = case target
                       when Todo
                         ['project_todo_list_todo',
                          {
                              project_id: target.project.id,
                              todo_list_id: target.todo_list.id,
                              id: target.id
                          }
                         ]
                       when Project
                         ['project', {id: target.id}]
                       when TodoList
                         [
                             'project_todo_list',
                             {
                                 project_id: target.project.id,
                                 id: target.id,
                             }
                         ]
                       when CalendarEvent
                         # TODO
                       else
                         ''
                     end
    url_helpers.send("#{method}_path", params) if method.present?
  end

  def event_body_url(event)
    "#{target_url(event.target)}/##{event.comment.id}"
  end

  def show_event_action(action)
    begin
      action_hash = JSON.parse(action)
      action_hash.to_options!
      action_hash[:action] % action_hash[:params].map { |param| to_chinese_date(param) }
    rescue JSON::ParserError => e
      action
    end
  end
end
