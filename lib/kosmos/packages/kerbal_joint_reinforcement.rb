class KerbalJointReinforcement < Kosmos::Package
  title 'Kerbal Joint Reinforcement'
  url 'http://download743.mediafire.com/e0ukt8149hhg/yvi7o1t6a36m5hk/KerbalJointReinforcement_v2.3.zip'

  def install
    merge_directory 'GameData'
  end
end
