class KerbalEngineerRedux < Kosmos::Package
  title 'Kerbal Engineer Redux'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2014/05/Engineer-Redux-v0.6.2.41.zip'

  def install
    merge_directory 'Engineer', into: 'GameData'
  end
end
