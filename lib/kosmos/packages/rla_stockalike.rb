class RLAStockalike < Kosmos::Package
  title 'RLA Stockalike'
  aliases 'RLA'
  
  url 'http://kerbal.curseforge.com/ksp-mods/220907-rla-stockalike-archive-mirror'

  def install
    merge_directory 'RLA Stockalike/GameData', into: '.'
  end
end

class RLAElectricEngines < Kosmos::Package
  title 'RLA Electric Engines'
  url 'http://kerbal.curseforge.com/ksp-mods/220907-rla-stockalike-archive-mirror'

  def install
    merge_directory 'RLA Electric Engines/GameData', into: '.'
  end
end

class RLAPowerGeneration < Kosmos::Package
  title 'RLA Power Generation'
  url 'http://kerbal.curseforge.com/ksp-mods/220907-rla-stockalike-archive-mirror'

  def install
    merge_directory 'RLA Power Generation/GameData', into: '.'
  end
end

