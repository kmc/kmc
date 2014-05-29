class DistantObjectEnhancement < Kosmos::Package
  title 'Distant Object Enhancement'
  url 'https://app.box.com/s/7xdwo92oc00dkjxkilwb'

  def install
    merge_directory 'GameData'
  end
end
