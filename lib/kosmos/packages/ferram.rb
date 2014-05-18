class FerramAerospaceResearch < Kosmos::Package
  title 'Ferram Aerospace Research'
  aliases 'ferram', 'far', 'ferram aerospace'

  homepage 'http://forum.kerbalspaceprogram.com/threads/20451-0-23-5-Ferram-Aerospace-Research-v0-13-3-4-30-14'
  url 'https://github.com/ferram4/Ferram-Aerospace-Research/releases/download/v0.13.3/FerramAerospaceResearch_v0_13_3.zip'

  def install
    merge_directory 'GameData'
    merge_directory 'Ships'
  end
end
