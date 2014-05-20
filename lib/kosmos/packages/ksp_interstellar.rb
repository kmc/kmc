class KSPInterstellar < Kosmos::Package
  title 'KSP Interstellar'
  aliases 'interstellar'

  url 'https://bitbucket.org/FractalUK/kspinstellar/downloads/KSPInterstellar-v0.11.zip'

  def install
    merge_directory 'GameData'
  end
end
