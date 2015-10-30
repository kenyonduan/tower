class AddListTypeToTodoLists < ActiveRecord::Migration
  def change
    add_column :todo_lists, :list_type, :integer
  end
end
