class GingerCorpStockalikeStationHubs < Kosmos::Package
  title 'GingerCorp Station Hubs'
  url 'http://kerbal.curseforge.com/parts/220639-gingercorp-stock-alike-station-hubs'

  def install
    merge_directory 'GingerCorp', into: 'GameData'
  end
end

