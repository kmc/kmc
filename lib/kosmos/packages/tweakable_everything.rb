class TweakableEverything < Kosmos::Package
  title 'Tweakable Everything'
  url 'http://ksp.hawkbats.com/TweakableEverything/TweakableEverything-1-2.zip'

  def install
    merge_directory 'GameData'
  end
end
