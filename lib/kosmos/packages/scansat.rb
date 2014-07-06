class Scansat < Kosmos::Package
  title 'SCANSat'
  url 'https://github.com/S-C-A-N/SCANsat/releases/download/v6.0/SCANsat_v6.0.zip'

  def install
    merge_directory 'GameData/SCANsat', into: 'GameData'
  end
end

class ScanSatRpm < Kosmos::Package
  title 'SCANSatRPM'
  url 'https://github.com/S-C-A-N/SCANsat/releases/download/v6.0/SCANsat_v6.0.zip'
  prerequisites 'scansat'

  def install
    merge_directory 'GameData/SCANsatRPM', into: 'GameData'
  end
end
