class ScienceAlert < Kosmos::Package
  title 'ScienceAlert'
  aliases 'science alert'
  url 'https://bitbucket.org/xEvilReeperx/ksp_sciencealert/downloads/KSP-23.5-ScienceAlert-release-1.5.zip'

  def install
    merge_directory 'GameData'
  end
end
