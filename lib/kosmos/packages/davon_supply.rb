class DavonSupply < Kosmos::Package
  title 'Davon Supply'
  url 'http://kerbal.curseforge.com/parts/220528-davon-supply-mod'

  def install
    merge_directory 'GameData'
  end
end

