class KerbalDustExperiment < Kosmos::Package
  title 'Kerbal Dust Experiment'
  aliases 'KDEX'
  url 'http://kerbal.curseforge.com/ksp-mods/222059-kdex'

  def install
    merge_directory 'masTerTorch', into: 'GameData'
  end
end
