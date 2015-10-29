class RemoveProjectIdInTodos < ActiveRecord::Migration
  def change
    remove_column :todos, :project_id
  end
end
