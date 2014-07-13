class TurboNisuStockalikeParts < Kosmos::Package
  title 'Stockalike parts for useful esthetics'
  aliases 'Stockalike parts for useful aesthetics', 'TurboNisu stockalike parts', 'TurboNisu aesthetic parts pack'
  
  url 'http://www.mediafire.com/download/et4ctfdh592a6sn/TurboNisuPartsPack1.02.rar'

  def install
    merge_directory 'GameData'
  end
end
