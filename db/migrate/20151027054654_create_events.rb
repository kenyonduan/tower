class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      # 公共属性
      t.string :action
      t.string :type # 单表继承
      t.belongs_to :initiator, index: true
      t.references :target, polymorphic: true, index: true
      t.references :projectable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
