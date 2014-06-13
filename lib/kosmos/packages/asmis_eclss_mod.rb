class AsmisECLSSMod < Kosmos::Package
  title 'Asmi\'s ECLSS Mod'
  url 'https://bitbucket.org/asmi/ksp/downloads/LifeSupportMod.1.0.15.zip'

  def install
    merge_directory 'GameData'
  end
end

