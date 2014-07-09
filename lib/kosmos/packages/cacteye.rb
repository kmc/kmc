class Cacteye < Kosmos::Package
  title 'CactEye Telescope'
  aliases 'cacteye'
  url 'https://app.box.com/s/89skim2e3simjwmuof4c'
  postrequisite 'cacteye recompiled with latest hullcam vds'

  def install
    merge_directory 'GameData'
    merge_directory 'Ships'
  end
end

class CacteyeRecompiledLatestHullcam < Kosmos::Package
  title 'CactEye Recompiled with Latest Hullcam VDS'
  url 'http://www.mediafire.com/download/iuiq2cwx0sh3124/CactEyeTelescope.dll'

  do_not_unzip!

  def install
    merge_directory 'CactEyeTelescope.dll', into: 'GameData/CactEye/Plugins'
  end
end
