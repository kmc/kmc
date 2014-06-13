class BahaExtraplanetaryParts < Kosmos::Package
  title 'Baha Extraplanetary Parts'
  url 'http://www.mediafire.com/download/cyn3bnpsy9p0z4g/bahaELpartsv1.2.zip'

  def install
    merge_directory 'GameData'
  end
end

