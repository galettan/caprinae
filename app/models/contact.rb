class Contact < ActiveRecord::Base

belongs_to :client, class_name: Client, foreign_key: "client_id"

validates :last_name, presence: true
validates :first_name, presence: true
validates :email, presence: true

def first_name_and_last_name
  "#{first_name} #{last_name}"
end

end