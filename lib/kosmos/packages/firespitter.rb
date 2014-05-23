class Firespitter < Kosmos::Package
  title 'Firespitter'
  url 'http://addons.cursecdn.com/files/2202/682/Firespitter.zip'

  def install
    merge_directory '.', into: 'GameData'
  end
end
