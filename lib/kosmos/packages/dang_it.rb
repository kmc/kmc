class DangIt < Kosmos::Package
  title 'Dang It'
  url 'https://github.com/Ippo343/DangIt/releases/download/0.0.2.1/GameData.zip'

  def install
    merge_directory 'GameData'
  end
end

