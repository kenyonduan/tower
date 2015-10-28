module EventsHelper
  # 对 event 进行分组(日期、Projectable)
  def events_group(events)
    events.group_by { |event| [event_day_format(event.created_at.to_date), event.projectable] }
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
    url_helpers.send("#{projectable.class.to_s.downcase}_url", target)
  end

  def target_name(target)
    target.try(:name) || target.try(:title) || ''
  end

  def target_url(target)
    url_helpers.send("#{target.class.to_s.downcase}_url", target)
  end

  def show_event_body(event)
    if event.respond_to?(:comment) && event.comment.present?
      "<a href='#{url_helpers.comment_url(event.comment)}'>#{event.comment.content}</a>"
    elsif event.detail.present?
      event.detail
    else
      ''
    end
  end
end
