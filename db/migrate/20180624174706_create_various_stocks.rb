class CreateVariousStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :various_stocks do |t|
    	t.string :name
    	t.string :color, :default => "#FFFFFF"
      t.timestamps
    end
  end
end
