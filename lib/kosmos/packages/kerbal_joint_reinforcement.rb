class KerbalJointReinforcement < Kosmos::Package
  title 'Kerbal Joint Reinforcement'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2014/04/KerbalJointReinforcement_v2.3.zip'

  def install
    merge_directory 'GameData'
  end
end
