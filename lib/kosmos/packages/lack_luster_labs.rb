class LackLusterLabs < Kosmos::Package
  title 'Lack Luster Labs'
  aliases 'LLL' 'Lack Luster Labs Pack'
  
  url 'https://www.dropbox.com/s/0h82wo8rdxu4jya/LLL-12-2.zip'

  def install
    merge_directory 'GameData/LLL', into: 'GameData'
  end
end

class StockExtension < Kosmos::Package
  title 'Stock eXTension'
  aliases 'SXT' 'LLL Stock eXTension'

  url 'https://dl.dropboxusercontent.com/u/39086055/SXT-16.5.zip'

  def install
    merge_directory 'GameData/SXT', into: 'GameData'
  end
end

