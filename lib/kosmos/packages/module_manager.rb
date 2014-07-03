class ModuleManager < Kosmos::Package
  title 'ModuleManager'
  aliases 'module manager'
  url 'https://ksp.sarbian.com/jenkins/job/ModuleManager/lastBuild/artifact/jenkins-ModuleManager-36/ModuleManager-2.1.5.zip'

  def install
    merge_directory 'ModuleManager.2.1.5.dll', into: 'GameData'
  end
end
