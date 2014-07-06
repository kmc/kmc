class ModularKolonizationSystem < Kosmos::Package
  title 'Modular Kolonization System'
  url 'https://www.dropbox.com/sh/1fsuzvl35s2gppt/AACiDPCa7ZNPhrNIYWCmGXRea/MKS_0.17.0.zip'

  def install
    merge_directory 'GameData'
  end
end
