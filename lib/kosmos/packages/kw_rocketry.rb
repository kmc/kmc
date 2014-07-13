class KWRocketry < Kosmos::Package
  title 'KW Rocketry'
  aliases 'KW'
  
  url 'http://www.mediafire.com/download/hxt2kfpctmcmt56/KW+Release+Package+v2.5.6B.zip'

  def install
    merge_directory 'KW Release Package v2.5.6B/GameData'
  end
end
