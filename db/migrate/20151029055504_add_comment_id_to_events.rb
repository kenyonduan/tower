class AddCommentIdToEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.belongs_to :comment, index: true
    end
  end
end
