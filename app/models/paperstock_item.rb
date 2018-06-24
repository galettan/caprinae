class PaperstockItem < ActiveRecord::Base

belongs_to :paperstock, class_name: Paperstock, foreign_key: "paperstock_id"

validates :name, presence: true

end