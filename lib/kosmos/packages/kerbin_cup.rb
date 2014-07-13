class KerbinCup < Kosmos::Package
  title 'Kerbin Cup'
  
  url 'http://kerbal.curseforge.com/ksp-mods/221319-kerbin-cup'

  def install
    merge_directory 'Kerbin Cup', into: 'GameData'
  end
end
