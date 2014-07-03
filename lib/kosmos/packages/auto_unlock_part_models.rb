class AutoUnlockPartModels < Kosmos::Package
  title 'Auto Unlock Part Models'
  url 'https://bitbucket.org/xEvilReeperx/ksp_autounlockpartmodels/downloads/KSP-0.23-AutoUnlockPartModels.zip'

  def install
    merge_directory 'GameData'
  end
end

