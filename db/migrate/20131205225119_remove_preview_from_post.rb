class RemovePreviewFromPost < ActiveRecord::Migration
  def up
    Post.all.each do |post|
      post.save
    end

    remove_column :posts, :preview
  end

  def down
    add_column :posts, :preview, :text
  end
end
