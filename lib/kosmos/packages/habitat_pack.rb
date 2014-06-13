class HabitatPack < Kosmos::Package
  title 'Habitat Pack'
  url 'https://www.dropbox.com/s/7rfuu6ott8j5bl7/Habitat%20Pack.zip'

  def install
    merge_directory 'GameData'
  end
end

