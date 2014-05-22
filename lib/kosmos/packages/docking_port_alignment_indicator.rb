class DockingPortAlignmentIndicator < Kosmos::Package
  title 'Docking Port Alignment Indicator'
  url 'http://addons.cursecdn.com/files/2201/632/DockingPortAlignment_3.1.zip'

  def install
    merge_directory 'GameData'
  end
end
