class VanguardTechnologies < Kosmos::Package
  title 'Vanguard Technologies'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2013/12/VNG-Plugin_0.7.2.zip'

  def install
    merge_directory 'VNG-Plugin/GameData'
  end
end

class VanguardTechnologiesEVAParachutes < Kosmos::Package
  title 'Vanguard Technologies - EVA Parachutes'
  aliases 'eva parachutes'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2013/10/VNG-Parachute_1.2.zip'

  def install
    merge_directory 'VNG-Parachute/GameData'
  end
end
