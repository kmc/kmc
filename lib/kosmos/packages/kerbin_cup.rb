class KerbinCup < Kosmos::Package
  title 'Kerbin Cup'
  
  url 'http://www.curse.com/ksp-mods/kerbal/221319-kerbin-cup'

  def install
    merge_directory 'Kerbin Cup', into: 'GameData'
  end
end
