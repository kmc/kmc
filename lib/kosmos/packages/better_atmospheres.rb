class BetterAtmospheresLowDef < Kosmos::Package
  title 'Better Atmospheres - Low Definition (512 x 512)'
  aliases 'better atmospheres - low def'
  url 'https://www.dropbox.com/s/ego5nirhdutj59l/Better%20Atmospheres%20V5%20Low%20Quality.zip'
  prerequisites 'environmental-visual-enhancements', 'texture-replacer', 'custom-asteroids'

  def install
    merge_directory 'BoulderCo',  into: 'GameData'
    merge_directory 'CustomAsteroids', into: 'GameData'
    merge_directory 'KittopiaSpace', into: 'GameData'
    merge_directory 'RealSolarSystem', into: 'GameData'
    merge_directory 'TextureReplacer', into: 'GameData'
  end
end

class BetterAtmospheresMediumDef < Kosmos::Package
  title 'Better Atmospheres - Medium Definition (1024 x 1024)'
  aliases 'better atmospheres - medium def', 'better atmospheres'
  url 'https://www.dropbox.com/s/qyw3gcdfcocvrt7/Better%20Atmospheres%20V5%20Medium%20Res.zip'
  prerequisites 'environmental-visual-enhancements', 'texture-replacer', 'custom-asteroids'

  def install
    merge_directory 'BoulderCo',  into: 'GameData'
    merge_directory 'CustomAsteroids', into: 'GameData'
    merge_directory 'KittopiaSpace', into: 'GameData'
    merge_directory 'RealSolarSystem', into: 'GameData'
    merge_directory 'TextureReplacer', into: 'GameData'
  end
end

class BetterAtmospheresHighDef < Kosmos::Package
  title 'Better Atmospheres - High Definition (2048 x 2048)'
  aliases 'better atmospheres - high def'
  url 'https://www.dropbox.com/s/mqw1rdc5p06mmsy/Better%20Atmospheres%20V5.zip'
  prerequisites 'environmental-visual-enhancements', 'texture-replacer', 'custom-asteroids'

  def install
    merge_directory 'BoulderCo',  into: 'GameData'
    merge_directory 'CustomAsteroids', into: 'GameData'
    merge_directory 'KittopiaSpace', into: 'GameData'
    merge_directory 'RealSolarSystem', into: 'GameData'
    merge_directory 'TextureReplacer', into: 'GameData'
  end
end
