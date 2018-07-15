class AddColorToPaperStock < ActiveRecord::Migration[5.0]
  def change
    add_column :paperstocks, :color, :string
    change_column :paperstock_items, :thirtytwofortyfive, :integer, :default => 0
    change_column :paperstock_items, :fiftytwoseventytwo, :integer, :default => 0
  end
end
