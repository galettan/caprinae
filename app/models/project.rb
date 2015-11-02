class Project < ActiveRecord::Base
  belongs_to :owner, class_name: User, foreign_key: "owner_id"
  belongs_to :worker, class_name: User, foreign_key: "worker_id"
  has_many :participants, :class_name => 'Participant'
  has_many :contacts, :through => :participants
  has_many :tasks
  has_many :feedbacks
  has_many :papers
  before_save :set_estimated_time

  scope :passed, -> (archived) {where archived: true}
  scope :number, -> (number) { where number: number}
  scope :user, -> (user) {where worker_id: user}
  scope :search_name, -> (name) {where("name LIKE ?", "#{name}%")}
  scope :client, -> (client) {distinct.joins('LEFT JOIN participants ON participants.project_id = projects.id')
    .joins('LEFT JOIN contacts ON contacts.id = participants.contact_id').where('contacts.client_id = ? ', client)}
  scope :create_date, -> (create_begin, create_end) {where("created_at BETWEEN DATE(?) AND DATE(?)", create_begin, create_end)}
  scope :project_type, -> (type) {where project_type: type}
  scope :progress, -> (progress) {where progression: progress}
  scope :status, -> (status) {where state: status}
  scope :prio, -> (prio) {where priority: prio}

  accepts_nested_attributes_for :tasks, :allow_destroy => true
  accepts_nested_attributes_for :feedbacks, :allow_destroy => true
  accepts_nested_attributes_for :participants, :allow_destroy => true
  accepts_nested_attributes_for :papers, :allow_destroy => true
  
  validates :name, presence: true
  validates :number, presence: true
  validates :worker, presence: true
  validates :first_feedback, presence: true
    
  enum project_type: [:print, :crea, :other, :creaprint, :creaother, :printother, :creaprintother]
  enum priority: [:normal, :urgent]
  enum state: [:running, :waitingclient, :validatedclient, :finished]
  enum progression: [:todocrea, :runningcrea, :finishedcrea, :todoprint, :runningprint, :finishedprint]

  enum colors: [:quadrir, :quadrirv, :quadrirnbv, :nbr, :nbrv]
  enum open_shape: [:a3oshape, :a4oshape, :a5oshape, :hundredseventybyfiftyfour, :hundredseventybyheightyfive, :twohundredbytwoten,
    :twofortybyhundred, :twoninetysevenbyhundred, :twoninetysevenbyoneofive, :threehundredbyoneandhalf, :fourtwentybytwoten, :fourtwentybyhundred,
    :fourtwentybyhundredandhalf, :fourfortybytwoten, :portrait, :landscape]
  enum finished_shape: [:indicatedshape, :various, :fortybythirtyheight, :heightyfivebyfifty, :heightyfivebyfiftyfour,
    :ninetybyfifty, :ninetybyfiftyfour, :ninetyfivebyfiftyfour, :heightyfivesq, :heightbyhundred, :heightytwobyhundredtwentyheight,
    :heightyfivebyhundred, :ninetyninebytwoten, :hundredbytwoten, :hundredfivebytwoten, :hundredtenbytwoten, :twotenbyhundredfifty,
    :twofivebyhundredten, :hundredbytwoninetyseven, :hundredfortybytwoninetyseven, :hundredfiftysq, :hundredheightytwobytwofiftyseven,
    :twotensq, :a3, :a4, :a5, :a6, :usletter, :seenotice, :sra3]
  enum filming: [:shinyrv, :dullrv, :shinyr, :dullr, :shinylaminating, :dulllaminating, :thirtysevenhalfmc, :heightymc, :hundredtwentyfivemc, :hundredseventyfivemc]
  enum shaping: [:cut, :rainage, :pierced, :piercedandbent, :cutting, :straddlesting, :rainageandstraddlesting, :cutrainagebent, :leftcornersting, :manualbending,
    :mechanicbending, :binding, :wireowhite, :wireosilver, :wireoblack, :frontcristal, :bothcristal, :flatback, :topofmindgluing, :leftgluing, :roundedcorner, 
    :badgepin, :hanginghole, :ringbinderhole, :variousshaping, :assemblygluing, :no]
  enum package: [:film, :kraft, :elasticedby, :packagedby, :box, :pallet, :carton]
  enum delivery: [:available, :wedeliver, :steed, :tnt, :ups, :clientups, :standardmail]
  enum test_print: [:notest, :yestest, :validated]

  def self.by_owner(id)
      @projects = Project.where("archived = false")
  end
  
  def self.for_crea(id)
    @projects = Project.where(["worker_id = ? AND archived = false AND progression < 2", id])
  end
  
  def self.for_print()
    @projects = Project.where(["project_type IN (0, 3, 5,6) AND archived = false AND progression >= 2 AND progression < 5"])
  end

  def self.find_detailed(id)
      @project = Project.includes(:owner, :worker, :participants, :tasks, :feedbacks).find(id)
  end
  
  def self.search(search)
    @projects = Project.where("name LIKE ?", "%#{search}%")
  end
  

  def set_estimated_time
    self.estimated_time = @hours * 60 + @minutes
  end
  
  def hours
    self.estimated_time / 60 if self.estimated_time?;
  end
  
  def minutes
    self.estimated_time % 60 if self.estimated_time?;
  end
  
  def hours=(h)
    @hours = h.to_i
  end
  
  def minutes=(m)
   @minutes = m.to_i
  end

end
