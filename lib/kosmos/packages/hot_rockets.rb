class HotRockets < Kosmos::Package
  title 'HotRockets'
  aliases 'hot rockets'
  url 'http://addons.cursecdn.com/files/2201/918/HotRockets_7.1_Nazari.zip'

  def install
    merge_directory 'ModuleManager.2.1.0.dll', into: 'GameData'
    merge_directory 'MP_Nazari', into: 'GameData'
    merge_directory 'SmokeScreen', into: 'GameData'
  end
end
