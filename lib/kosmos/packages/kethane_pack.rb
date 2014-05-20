class KethanePack < Kosmos::Package
  title 'Kethane Pack'
  aliases 'kethane'
  url 'https://nabaal.net/files/kethane/Kethane-0.8.5.zip'

  def install
    merge_directory 'GameData'
  end
end
