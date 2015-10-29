class AddTodoListIdToTodos < ActiveRecord::Migration
  def change
    change_table :todos do |t|
      t.belongs_to :todo_list, index: true
    end
  end
end
