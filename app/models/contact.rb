class Contact < ActiveRecord::Base

belongs_to :client, class_name: Client, foreign_key: "client_id"
has_many :participants, :class_name => 'Participant'
has_many :projects, :through => :participant

validates :last_name, presence: true
validates :first_name, presence: true
validates :email, presence: true

before_destroy :update_projects

def first_name_and_last_name
  "#{first_name} #{last_name}"
end

def update_projects
	participants.each do |participant|
		participant.destroy
	end
end

end