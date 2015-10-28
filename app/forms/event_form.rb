class EventForm
  attr_accessor :p_ids, :c_ids, :page

  def p_ids
    @p_ids || []
  end

  def c_ids
    @c_ids || []
  end

  def page
    @page || 1
  end

  # TODO 如果采取全局 uuid 是否就不用传递 projectable_type 了?
  def query
    Event.includes(:target, :initiator).where(
        '(projectable_type=? and projectable_id IN(?)) OR (projectable_type=? and projectable_id IN(?))',
        'Project', p_ids,
        'Calendar', c_ids
    ).order(created_at: :desc).per(50).page(page)
  end
end