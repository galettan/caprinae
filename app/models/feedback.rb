class Feedback < ActiveRecord::Base
  belongs_to :project, class_name: Project, foreign_key: "project_id"
  belongs_to :worker, class_name: User, foreign_key: "worker_id"
  
  validates :description, presence: true
  validates :worker_id, presence: true
end