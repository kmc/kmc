class StationScience < Kosmos::Package
  title 'Station Science'
  url 'http://kerbal.curseforge.com/ksp-mods/220216-station-science-v-0-4'

  def install
    merge_directory 'StationScience', into: 'GameData'
  end
end
