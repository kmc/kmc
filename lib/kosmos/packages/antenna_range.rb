class AntennaRange < Kosmos::Package
  title 'AntennaRange'
  aliases 'antenna range'
  url 'http://ksp.hawkbats.com/AntennaRange/AntennaRange-1-3.zip'

  def install
    merge_directory 'GameData'
  end
end

