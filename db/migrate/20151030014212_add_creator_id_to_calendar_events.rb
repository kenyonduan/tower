class AddCreatorIdToCalendarEvents < ActiveRecord::Migration
  def change
    change_table :calendar_events do |t|
      t.belongs_to :creator, index: true
    end
  end
end
