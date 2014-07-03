class KerbalStockParteXpansion < Kosmos::Package
  title 'KerbalStockParteXpansion'
  aliases 'kspx'
  url 'https://www.dropbox.com/s/jlsil0uhkfipbye/KSPX%20v0.2.6.1.zip'

  def install
    merge_directory 'GameData'
  end
end
