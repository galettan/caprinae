class Paper < ActiveRecord::Base
  belongs_to :project, class_name: Project, foreign_key: "project_id"
  validates :paper, presence: true

  enum paper: [:layhalfmat,:laymat, :layshine, :layrefurb, :offsettype, :offsetrefurb, :offsetlaser,
    :reprocolor, :opale, :bristol, :retightadhesiv, :adhesivnoretight, :piercedadhesiv, :labelboard,
    :windowenvelope, :envelope, :cbcf,:cbcfbcf, :colorfile, :creapaper, :provideddoc]
  enum density: [:sixty, :heighty, :ninety, :hundred, :hundredten, :hundredfifteen, :hundredtwenty,
    :hundredthirtyfive, :hundredfifty, :hundredseventy, :hundredninety, :twohundred, :twohundredfifty,
    :threehundred, :threehundredtwenty, :threehundredfifty, :fourhundred, :otherdensity]
  enum shape: [:sra3shape, :a3shape, :sra4shape, :a4shape, :hundredtenbytwotwenty, :fourheightybythreethirty,
    :onesixtytwobytwotwentynine, :twotwentyninebythreetwentyfour]
end
