class KWRocketry < Kosmos::Package
  title 'KW Rocketry'
  url 'http://download2013.mediafire.com/u9mywi5euieg/hxt2kfpctmcmt56/KW+Release+Package+v2.5.6B.zip'

  def install
    merge_directory 'KW Release Package v2.5.6B/GameData'
  end
end
