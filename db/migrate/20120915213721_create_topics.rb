class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :category_id
      t.string :name
      t.integer :posts_count, :default => 0

      t.timestamps
    end
  end
end
