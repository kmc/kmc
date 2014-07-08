class BahaExtraplanetaryParts < Kosmos::Package
  title 'BahamutoD\'s Drills and Parts for EL'
  aliases 'BahamutoDs drills and parts', 'el drills and parts',
    'baha extraplanetary parts'
  url 'http://www.mediafire.com/download/cyn3bnpsy9p0z4g/bahaELpartsv1.2.zip'

  def install
    merge_directory 'GameData'
  end
end

