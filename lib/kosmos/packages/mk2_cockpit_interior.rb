class Mk2CockpitInterior < Kosmos::Package
  title 'Mk2 Cockpit Interior'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2013/12/SH-MK2Cockpit.zip'

  def install
    merge_directory 'GameData'
  end
end
