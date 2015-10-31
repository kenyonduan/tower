class RemoveStatusDefaultValueInTodos < ActiveRecord::Migration
  def up
    change_column :todos, :status, :integer, :default => nil
  end

  def down
    change_column :todos, :status, :integer, :default => 0
  end
end
