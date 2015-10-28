class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.string :content
      t.date :begin
      t.date :end
      t.date :remind_time
      t.text :location
      t.boolean :is_show_creator
      t.references :caleventable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
