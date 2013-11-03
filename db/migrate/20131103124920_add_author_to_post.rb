class AddAuthorToPost < ActiveRecord::Migration
  def change
    add_column :posts, :author_id, :string
    add_column :posts, :author_name, :string
  end
end
