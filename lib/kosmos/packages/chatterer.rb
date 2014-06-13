class Chatterer < Kosmos::Package
  title 'Chatterer'
  url 'https://www.dropbox.com/s/y2ccc5ozjf13cds/Chatterer_0.5.9.3.zip'

  def install
    merge_directory 'GameData'
  end
end

