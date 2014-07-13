class Mk2CockpitInterior < Kosmos::Package
  title 'Mk2 Cockpit Interior'
  aliases 'Mk2 cockpit internals'
  
  url 'http://kerbal.curseforge.com/ksp-mods/220927-mk2-cockpit-internals'

  def install
    merge_directory 'GameData'
  end
end
