class DeleteCategories < ActiveRecord::Migration
  def up
    drop_table :categories
  end

  def down
    create_table "categories", :force => true do |t|
      t.string   "name"
      t.string   "avatar"
      t.integer  "topics_count", :default => 0
    end
  end
end
