class BetterRoveMates < Kosmos::Package
  title 'Better RoveMates'
  url 'http://kerbal.curseforge.com/parts/220209-betterrovemates'

  def install
    merge_directory 'GameData'
  end
end

