class EnableClient < ActiveRecord::Migration
  def change
    add_column :clients, :disable, :bool
  end
end
