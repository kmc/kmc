class Toolbar < Kosmos::Package
  title 'Toolbar Plugin'
  aliases 'toolbar'
  url 'http://blizzy.de/toolbar/Toolbar-1.7.3.zip'

  def install
    merge_directory 'Toolbar-1.7.3/GameData'
  end
end
