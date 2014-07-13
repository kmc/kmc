class KerbinCup < Kosmos::Package
  title 'Kerbin Cup'
  
  url 'http://kerbal.curseforge.com/ksp-mods/221319-kerbin-cup'

  def install
    merge_directory 'WorldCup2014', into: 'GameData'
  end
end
