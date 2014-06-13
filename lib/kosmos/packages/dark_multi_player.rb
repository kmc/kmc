class DarkMultiPlayer < Kosmos::Package
  title 'DarkMultiPlayer'
  aliases 'dark multi player'
  url 'http://kerbal.curseforge.com/ksp-mods/221242-darkmultiplayer-client'

  def install
    merge_directory 'DMPClient/GameData'
  end
end

