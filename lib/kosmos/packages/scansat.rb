class Scansat < Kosmos::Package
  title 'SCANSat'
  url 'http://github.com/thatfool/SCAN/releases/download/build5/SCANsat_b5.zip'

  def install
    merge_directory 'SCANsat', into: 'GameData'
  end
end
