class Contact < ActiveRecord::Base

belongs_to :client, class_name: Client, foreign_key: "client_id"

validates :last_name, presence: true
validates :first_name, presence: true
validates :email, presence: true

end