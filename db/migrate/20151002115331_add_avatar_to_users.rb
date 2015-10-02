class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :avatar
    remove_column :users, :photo
  end
end
