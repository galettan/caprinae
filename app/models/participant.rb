class Participant < ActiveRecord::Base
  belongs_to :project
  belongs_to :contact
  
  validates :contact_id, presence: true

  
end