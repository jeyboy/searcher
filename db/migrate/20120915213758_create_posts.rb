class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :topic_id
      t.string :name
      t.text :body
      t.integer :preview_count, :default => nil
      t.text :preview, :default => nil

      t.timestamps
    end
  end
end
