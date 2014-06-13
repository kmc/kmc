class ConstellationEssentials < Kosmos::Package
  title 'Constellation Essentials'
  url 'https://dl.dropboxusercontent.com/u/103148235/bahaConstellaitonv1.3.1RSS.zip'

  def install
    merge_directory 'GameData'
  end
end

