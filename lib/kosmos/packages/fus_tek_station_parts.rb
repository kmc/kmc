class FusTekStationParts < Kosmos::Package
  title 'FusTek Station Parts'
  url 'http://kerbal.curseforge.com/parts/220253-fustek-station-parts-x0-04-3-dev-build'

  def install
    merge_directory 'GameData'
  end
end

