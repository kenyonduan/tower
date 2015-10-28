class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :name
      t.belongs_to :creator, index: true
      t.belongs_to :team, index: true

      t.timestamps null: false
    end
  end
end
