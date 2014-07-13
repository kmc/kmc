class KerbalJointReinforcement < Kosmos::Package
  title 'Kerbal Joint Reinforcement'
  aliases 'kjr'
  
  url 'http://www.mediafire.com/download/yvi7o1t6a36m5hk/KerbalJointReinforcement_v2.3.zip'

  def install
    merge_directory 'GameData'
  end
end
