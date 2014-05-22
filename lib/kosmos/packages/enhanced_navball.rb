class EnhancedNavball < Kosmos::Package
  title 'Enhanced Navball'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2013/09/EnhancedNavBall_1_2.zip'

  def install
    merge_directory 'EnhancedNavBall/Plugins'
  end
end
