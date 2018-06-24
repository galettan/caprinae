class VariousStockItem < ActiveRecord::Base

belongs_to :various_stock, class_name: VariousStock, foreign_key: "various_stock_id"

validates :name, presence: true

end