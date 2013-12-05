class ExtendPostByPrettyFields < ActiveRecord::Migration
  def change
    add_column :posts, :pretty_body, :text
    add_column :posts, :pretty_preview, :text
  end
end
