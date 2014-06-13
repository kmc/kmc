class HangarExtender < Kosmos::Package
  title 'Hangar Extender'
  url 'http://kerbal.curseforge.com/ksp-mods/220250-hangar-extender'

  def install
    merge_directory 'FShangerExtender', into: 'GameData'
  end
end

