module CustomDateHelper
  CHINESE_DAYS = {
      1 => '一',
      2 => '二',
      3 => '三',
      4 => '四',
      5 => '五',
      6 => '六',
      7 => '日'
  }

  def to_chinese_date(target_date)
    return if target_date.blank?

    now = Time.now
    case target_date
      when now.beginning_of_day..now.end_of_day
        '今天'
      when now.end_of_day..tomorrow_end
        '明天'
      when tomorrow_end..now.end_of_week
        "本周#{CHINESE_DAYS[day_of_week(target_date)]}"
      when now.end_of_week..next_week_end
        "下周#{CHINESE_DAYS[day_of_week(target_date)]}"
      when next_week_end..now.end_of_year
        target_date.strftime('%m月%d日')
      else
        target_date.strftime('%Y年%m月%d日')
    end
  end

  def today_end
    Time.now.end_of_day
  end

  def day_of_week(target=today_end)
    target.strftime('%u').to_i
  end

  def tomorrow_end
    today_end + 1.day
  end

  def next_week_end
    (today_end + 1.week).end_of_week
  end
end