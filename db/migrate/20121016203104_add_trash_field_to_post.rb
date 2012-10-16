class AddTrashFieldToPost < ActiveRecord::Migration
  def change
    add_column :posts, :trash, :boolean, :default => false
  end
end
