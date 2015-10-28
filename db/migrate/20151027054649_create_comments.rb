class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :commentable, polymorphic: true, index: true
      t.belongs_to :event, index: true
      t.belongs_to :creator, index: true

      t.timestamps null: false
    end
  end
end
