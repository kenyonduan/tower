class ChangeActionTypeToText < ActiveRecord::Migration
  def change
    change_column :events, :action, :text
  end
end
