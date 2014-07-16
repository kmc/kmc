class VesselViewerStandalone < Kosmos::Package
  title 'Vessel Viewer - Standalone'
  aliases 'Vessel Viewer Standalone'
  url 'https://www.dropbox.com/s/85djze1nfffhdfh/VVStandalone.zip'
  prerequisites 'toolbar'

  def install
    merge_directory 'VesselView', into: 'GameData'
  end
end

class VesselViewerRPM < Kosmos::Package
  title 'Vessel Viewer - RPM'
  aliases 'Vessel Viewer RPM'
  url 'https://www.dropbox.com/s/u6q88ss75pt9nms/VVRPM.zip'
  prerequisites 'raster-prop-monitor'

  def install
    merge_directory 'VesselView', into: 'GameData'
  end
end


