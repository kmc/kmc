class ActionGroupManager < Kosmos::Package
  title 'Action Group Manager'
  aliases 'AGM'
  url 'https://github.com/SirJu/ActionGroupManager/releases/download/1.3.2.0/AGM.1.3.2.0.zip'
  prerequisites 'toolbar'

  def install
    merge_directory 'GameData/ActionGroupManager', into: 'GameData'
  end
end

