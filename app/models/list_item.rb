class ListItem < ActiveRecord::Base

belongs_to :list, class_name: List, foreign_key: "list_id"

validates :name, presence: true

end