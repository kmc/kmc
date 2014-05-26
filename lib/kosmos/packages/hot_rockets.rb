class HotRockets < Kosmos::Package
  title 'HotRockets'
  aliases 'hot rockets'
  url 'http://kerbal.curseforge.com/plugins/220207-hotrockets-particle-fx-replacement'

  def install
    merge_directory 'ModuleManager.2.1.0.dll', into: 'GameData'
    merge_directory 'MP_Nazari', into: 'GameData'
    merge_directory 'SmokeScreen', into: 'GameData'
  end
end
