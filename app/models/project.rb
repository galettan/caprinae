class Project < ActiveRecord::Base
  belongs_to :owner, class_name: User, foreign_key: "owner_id"
  belongs_to :worker, class_name: User, foreign_key: "worker_id"
#  belongs_to :contact, class_name: Contact, foreign_key: "contact_id"
  has_many :participants, :class_name => 'Participant'
  has_many :contacts, :through => :participants
  has_many :tasks
  has_many :feedbacks
  before_save :set_estimated_time


  accepts_nested_attributes_for :tasks, :allow_destroy => true
  accepts_nested_attributes_for :feedbacks, :allow_destroy => true
  accepts_nested_attributes_for :participants, :allow_destroy => true

  validates :name, presence: true
  validates :number, presence: true
  validates :worker, presence: true
  validates :first_feedback, presence: true
    
  enum project_type: [:print, :crea, :other, :creaprint, :creaother, :printother]
  enum priority: [:normal, :urgent]
  enum state: [:running, :waitingclient, :validatedclient, :finished]
  enum progression: [:todocrea, :runningcrea, :finishedcrea, :todoprint, :runningprint, :finishedprint]

  enum colors: [:quadrir, :quadrirv, :quadrirnbv, :nbr, :nbrv]
  enum open_shapes: [:a3oshape, :a4oshape, :a5oshape, :hundredseventybyfiftyfour, :hundredseventybyheightyfive, :twohundredbytwoten,
    :twofortybyhundred, :twoninetysevenbyhundred, :twoninetysevenbyoneofive, :threehundredbyoneandhalf, :fourtwentybytwoten, :fourtwentybyhundred,
    :fourtwentybyhundredandhalf, :fourfortybytwoten, :portrait, :landscape]
  enum finished_shapes: [:indicatedshape, :various, :fortybythirtyheight, :heightyfivebyfifty, :heightyfivebyfiftyfour,
    :ninetybyfifty, :ninetybyfiftyfour, :ninetyfivebyfiftyfour, :heightyfivesq, :heightbyhundred, :heightytwobyhundredtwentyheight,
    :heightyfivebyhundred, :ninetyninebytwoten, :hundredbytwoten, :hundredfivebytwoten, :hundredtenbytwoten, :twotenbyhundredfifty,
    :twofivebyhundredten, :hundredbytwoninetyseven, :hundredfortybytwoninetyseven, :hundredfiftysq, :hundredheightytwobytwofiftyseven,
    :twotensq, :a3, :a4, :a5, :a6, :usletter, :seenotice, :sra3]
  enum filmings: [:shinyrv, :dullrv, :shinyr, :dullr, :shinylaminating, :dulllaminating, :thirtysevenhalfmc, :heightymc, :hundredtwentyfivemc, :hundredseventyfivemc]
  enum shapings: [:cut, :rainage, :pierced, :piercedandbent, :cutting, :straddlesting, :rainageandstraddlesting, :cutrainagebent, :leftcornersting, :manualbending,
    :mechanicbending, :binding, :wireowhite, :wireosilver, :wireoblack, :frontcristal, :bothcristal, :flatback, :topofmindgluing, :leftgluing, :roundedcorner, 
    :badgepin, :hanginghole, :ringbinderhole, :variousshaping, :assemblygluing, :no]
  enum packages: [:film, :kraft, :elasticedby, :packagedby, :box, :pallet, :carton]
  enum deliveries: [:available, :wedeliver, :steed, :tnt, :ups, :clientups, :standardmail]
  
  
  #model paper
  enum paper_type: [:layhalfmat,:laymat, :layshine, :layrefurb, :offsettype, :offsetrefurb, :offsetlaser,
    :reprocolor, :opale, :bristol, :retightadhesiv, :adhesivnoretight, :piercedadhesiv, :labelboard,
    :windowenvelope, :envelope, :cbcf,:cbcfbcf, :colorfile, :creapaper, :provideddoc]
  enum paper_density: [:sixty, :heighty, :ninety, :hundred, :hundredten, :hundredfifteen, :hundredtwenty,
    :hundredthirtyfive, :hundredfifty, :hundredseventy, :hundredninety, :twohundred, :twohundredfifty,
    :threehundred, :threehundredtwenty, :threehundredfifty, :fourhundred, :otherdensity]
  enum paper_shape: [:sra3shape, :a3shape, :sra4shape, :a4shape, :hundredtenbytwotwenty, :fourheightybythreethirty,
    :onesixtytwobytwotwentynine, :twotwentyninebythreetwentyfour]

  def self.by_owner(id)
      @projects = Project.where(["owner_id = ? AND archived = false", id])
  end
  
  def self.by_profile(id)
    @projects = Project.where(["worker_id = ? AND archived = false", id])
  end

  def self.find_detailed(id)
      @project = Project.includes(:owner, :worker, :participants, :tasks, :feedbacks).find(id)
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
