class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :name
      t.belongs_to :project, index: true
      t.belongs_to :creator, index: true

      t.timestamps null: false
    end
  end
end
