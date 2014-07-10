class IonEngineSoundPack < Kosmos::Package
  title 'Ion Engine Sound Pack'
  aliases 'Ion Engine Sound'
  url 'http://kerbal.curseforge.com/ksp-mods/220940-original-ion-engine-sound-pack-0-235-arm'

  def install
    merge_directory 'GameData'
  end
end

