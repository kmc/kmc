class EnhancedNavball < Kosmos::Package
  title 'Enhanced Navball'
  url 'http://addons.cursecdn.com/files/2201/977/EnhancedNavBall_1_2.zip'

  def install
    merge_directory 'EnhancedNavBall/Plugins'
  end
end
