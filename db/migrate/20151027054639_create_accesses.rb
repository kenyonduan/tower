class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.belongs_to :user, index: true
      t.references :resource, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
