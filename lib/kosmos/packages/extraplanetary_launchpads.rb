class ExtraplanetaryLaunchpads < Kosmos::Package
  title 'Extraplanetary Launchpads'
  aliases 'extraplanetary-launchpads'
  url 'http://taniwha.org/~bill/Extraplanetary_Launchpads_v4.1.2.zip'

  def install
    merge_directory 'ExtraplanetaryLaunchpads', into: 'GameData'
  end
end
