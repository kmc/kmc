class ECLSS < Kosmos::Package
  title 'ECLSS Life Support'
  aliases 'eclss'
  url 'https://bitbucket.org/asmi/ksp/downloads/LifeSupportMod.1.0.15.zip'

  def install
    merge_directory 'GameData'
  end
end
