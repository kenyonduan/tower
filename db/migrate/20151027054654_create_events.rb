class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      # 公共属性
      t.string :action
      t.string :type # 单表继承
      t.belongs_to :initiator, index: true
      t.references :target, polymorphic: true, index: true
      t.references :projectable, polymorphic: true, index: true

      # 用作 CommentEvent 的 comment content
      t.text :detail

      t.timestamps null: false
    end
  end
end
