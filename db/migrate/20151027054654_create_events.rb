class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :action
      t.text :details
      t.belongs_to :initiator, index: true
      t.references :resource, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
