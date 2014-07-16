class TreeLoader < Kosmos::Package
  title 'TreeLoader'
  url 'http://kerbal.curseforge.com/ksp-mods/221687-treeloader'

  def install
    merge_directory 'TreeLoader', into: 'GameData'
  end
end

