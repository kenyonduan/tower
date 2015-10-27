class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.integer :status, default: 0
      t.belongs_to :project, index: true
      t.belongs_to :creator, index: true
      t.belongs_to :assignee, index: true

      t.timestamps null: false
    end
  end
end
