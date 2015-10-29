class AddCreatorIdToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.belongs_to :creator, index: true
    end
  end
end
