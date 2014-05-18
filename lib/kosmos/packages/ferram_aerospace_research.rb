class FerramAerospaceResearch < Kosmos::Package
  title 'Ferram Aerospace Research'
  aliases 'ferram', 'far', 'ferram aerospace'

  url 'https://github.com/ferram4/Ferram-Aerospace-Research/releases/download/v0.13.3/FerramAerospaceResearch_v0_13_3.zip'

  def install
    merge_directory 'GameData'
    merge_directory 'Ships'
  end
end
