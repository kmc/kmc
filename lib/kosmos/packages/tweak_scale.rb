class TweakScale < Kosmos::Package
  title 'TweakScale'
  url 'http://kerbal.curseforge.com/ksp-mods/220549-tweakscale'
  prerequisites 'module-manager'

  def install
   merge_directory 'Gamedata/TweakScale', into: 'GameData'
  end
end
