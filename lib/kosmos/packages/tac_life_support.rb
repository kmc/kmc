class TACLifeSupport < Kosmos::Package
  title 'TAC Life Support (WIP)'
  aliases 'tac life support', 'TACLS'
  
  url 'https://github.com/taraniselsu/TacLifeSupport/releases/download/Release_v0.8/TacLifeSupport_0.8.0.4.zip'
  prerequisites 'module-manager'

  def install
    merge_directory 'GameData'
  end
end
