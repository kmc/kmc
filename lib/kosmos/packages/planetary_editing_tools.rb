class PlanetaryEditingTools < Kosmos::Package
  title 'Planetary Editing Tools'
  url 'https://dl.dropboxusercontent.com/u/80556647/PlanetaryEditingToolsUI.zip'

  def install
    merge_directory 'KittopiaSpace', into: 'GameData'
  end
end
