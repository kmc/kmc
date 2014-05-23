class KWRocketry < Kosmos::Package
  title 'KW Rocketry'
  url 'http://download1434.mediafire.com/6fiuc8iw8uwg/hxt2kfpctmcmt56/KW+Release+Package+v2.5.6B.zip'

  def install
    merge_directory 'KW Release Package v2.5.6B/GameData'
  end
end
