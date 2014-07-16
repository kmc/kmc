class KerbalAircraftExpansion < Kosmos::Package
  title 'Kerbal Aircraft Expansion'
  aliases 'KAX'
  
  url 'http://kerbal.curseforge.com/ksp-mods/221780-kerbal-aircraft-expansion-kax'

  def install
    merge_directory 'GameData'
  end
end
