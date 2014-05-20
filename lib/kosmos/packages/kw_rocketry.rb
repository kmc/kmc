class KWRocketry < Kosmos::Package
  title 'KW Rocketry'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2013/12/KW-Release-Package-v2.5.6B.zip'

  def install
    merge_directory 'KW Release Package v2.5.6B/GameData'
  end
end
