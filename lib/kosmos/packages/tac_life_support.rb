class TACLifeSupport < Kosmos::Package
  title 'TAC Life Support (WIP)'
  aliases 'tac life support'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2013/12/TacLifeSupport_0.8.0.4.zip'

  def install
    merge_directory 'GameData'
  end
end
