class RasterPropMonitor < Kosmos::Package
  title 'Raster Prop Monitor'
  aliases 'jsi'
  url 'http://kerbal.curseforge.com/ksp-mods/221222-rasterpropmonitor'

  def install
    merge_directory 'GameData'
  end
end
