class VanguardTechnologies < Kosmos::Package
  title 'Vanguard Technologies'
  url 'https://dl.dropboxusercontent.com/u/82912977/Vanguard/VNG-Plugin_0.7.2.zip'

  def install
    merge_directory 'VNG-Plugin/GameData'
  end
end

class VanguardTechnologiesEVAParachutes < Kosmos::Package
  title 'Vanguard Technologies - EVA Parachutes'
  aliases 'eva parachutes', 'vanguard eva parachutes'
  url 'https://dl.dropboxusercontent.com/u/82912977/Vanguard/VNG-Parachute_1.2.zip'

  def install
    merge_directory 'VNG-Parachute/GameData'
  end
end
