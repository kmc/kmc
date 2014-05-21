class BetterAtmospheresLowDef < Kosmos::Package
  title 'Better Atmospheres - Low Definition (512 x 512)'
  aliases 'better atmospheres - low def'
  url 'https://dl.dropboxusercontent.com/s/od4kickxt92jpo2/BetterAtmosphereV4%5BREL%5D.zip?dl=1&token_hash=AAHYhNPX8HwDaTJMtH3TkeQ7Hhb2zpwP9bIgPQitfnhL8w&expiry=1400637112'

  def install
    merge_directory 'GameData'
    merge_directory 'City Textures/512/DetailCity.tga',
      into: 'GameData/BoulderCo/CityLights/Textures'
    merge_directory 'City Textures/512/detail.tga',
      into: 'GameData/BoulderCo/Clouds/Textures'
  end
end

class BetterAtmospheresMediumDef < Kosmos::Package
  title 'Better Atmospheres - Medium Definition (1024 x 1024)'
  aliases 'better atmospheres - medium def', 'better atmospheres'
  url 'https://dl.dropboxusercontent.com/s/od4kickxt92jpo2/BetterAtmosphereV4%5BREL%5D.zip?dl=1&token_hash=AAHYhNPX8HwDaTJMtH3TkeQ7Hhb2zpwP9bIgPQitfnhL8w&expiry=1400637112'

  def install
    merge_directory 'GameData'
    merge_directory 'City Textures/1024/DetailCity.tga',
      into: 'GameData/BoulderCo/CityLights/Textures'
    merge_directory 'City Textures/1024/detail.tga',
      into: 'GameData/BoulderCo/Clouds/Textures'
  end
end

class BetterAtmospheresHighDef < Kosmos::Package
  title 'Better Atmospheres - High Definition (2048 x 2048)'
  aliases 'better atmospheres - high def'
  url 'https://dl.dropboxusercontent.com/s/od4kickxt92jpo2/BetterAtmosphereV4%5BREL%5D.zip?dl=1&token_hash=AAHYhNPX8HwDaTJMtH3TkeQ7Hhb2zpwP9bIgPQitfnhL8w&expiry=1400637112'

  def install
    merge_directory 'GameData'
    merge_directory 'City Textures/2048/DetailCity.tga',
      into: 'GameData/BoulderCo/CityLights/Textures'
    merge_directory 'City Textures/2048/detail.tga',
      into: 'GameData/BoulderCo/Clouds/Textures'
  end
end
