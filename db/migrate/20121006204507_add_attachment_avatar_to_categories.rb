class AddAttachmentAvatarToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.has_attached_file :avatar
    end

    remove_column :categories, :avatar
  end

  def self.down
    drop_attached_file :categories, :avatar
    add_column :categories, :avatar, :string
  end
end
