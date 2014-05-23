class TACLifeSupport < Kosmos::Package
  title 'TAC Life Support (WIP)'
  aliases 'tac life support'
  url 'https://github.com/taraniselsu/TacLifeSupport/releases/download/Release_v0.8/TacLifeSupport_0.8.0.4.zip'

  def install
    merge_directory 'GameData'
  end
end
