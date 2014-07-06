class Scansat < Kosmos::Package
  title 'SCANSat'
  url 'https://github.com/S-C-A-N/SCANsat/releases/download/v6.0/SCANsat_v6.0.zip'

  def install
    merge_directory 'SCANsat', into: 'GameData'
  end
end

class ScanSatRpm < Kosmos::Package
  title 'SCANSat RPM'
  url 'https://github.com/S-C-A-N/SCANsat/releases/download/v6.0/SCANsat_v6.0.zip'
  prerequisites 'scansat'

  def install
    merge_directory 'SCANsatRPM', into: 'GameData'
  end
end
