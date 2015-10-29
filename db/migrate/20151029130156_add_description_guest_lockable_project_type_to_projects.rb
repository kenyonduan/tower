class AddDescriptionGuestLockableProjectTypeToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.text :description
      t.boolean :guest_lockable, :default => false
      t.integer :project_type
    end
  end
end
