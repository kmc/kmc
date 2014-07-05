class KOS < Kosmos::Package
  title 'kOS'
  url 'http://kerbal.curseforge.com/ksp-mods/220265-kos-scriptable-autopilot-system'

  def install
    merge_directory 'GameData'
  end
end
