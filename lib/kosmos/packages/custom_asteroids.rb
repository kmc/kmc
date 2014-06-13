class CustomAsteroids < Kosmos::Package
  title 'Custom Asteroids'
  url 'https://github.com/Starstrider42/Custom-Asteroids/releases/download/v1.0.0/CustomAsteroids_v1.0.0.zip'

  def install
    merge_directory 'GameData'
  end
end

