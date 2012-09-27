class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :avatar
      t.integer :topics_count, :default => 0

      t.timestamps
    end
  end
end
