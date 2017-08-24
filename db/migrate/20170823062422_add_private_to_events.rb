class AddPrivateToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :private, :boolean, default: false
  end
end
