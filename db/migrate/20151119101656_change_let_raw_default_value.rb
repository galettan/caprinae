class ChangeLetRawDefaultValue < ActiveRecord::Migration
  def change
    change_column_default :projects, :let_raw, 0
  end
end
