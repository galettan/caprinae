class Project < ActiveRecord::Base
  belongs_to :owner, class_name: User, foreign_key: "owner_id"
  belongs_to :worker, class_name: User, foreign_key: "worker_id"
  
  validates :name, presence: true
  validates :number, presence: true
  validates :worker, presence: true
  validates :first_feedback, presence: true
  
  enum project_type: [:print, :crea, :printcrea]

  def self.find_detailed(id)
      @project = Project.includes(:owner, :worker).find(id)    
  end

end
