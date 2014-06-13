class ConicsConfigurator < Kosmos::Package
  title 'Conics Configurator'
  url 'https://www.dropbox.com/s/srju59gp5dz7m1w/ConicsConfig.zip'

  def install
    merge_directory 'ConicsConfig', into: 'GameData'
  end
end

