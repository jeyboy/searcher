class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :counter, default: 0

      t.timestamps
    end
  end
end
