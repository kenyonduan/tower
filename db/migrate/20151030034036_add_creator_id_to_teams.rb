class AddCreatorIdToTeams < ActiveRecord::Migration
  def change
    change_table :teams do |t|
      t.belongs_to :creator, index: true
    end
  end
end
