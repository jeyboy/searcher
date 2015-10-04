class CreateTaggables < ActiveRecord::Migration
  def change
    create_table :taggables do |t|
      t.string :tagged_type
      t.integer :tagged_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
