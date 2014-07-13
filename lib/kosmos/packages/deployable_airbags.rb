class DeployableAirbags < Kosmos::Package
  title 'Deployable Airbags'
  
  url 'https://www.dropbox.com/sh/1fsuzvl35s2gppt/AADIbgIr7TeRKaD3Spucn8rNa/Airbags_0.1.3.zip'
  prerequisites 'kerbin-cup'

  def install
    merge_directory 'UmbraSpaceIndustries', into: 'GameData'
  end
end
