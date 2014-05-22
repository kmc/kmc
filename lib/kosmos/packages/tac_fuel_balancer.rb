class TACFuelBalancer < Kosmos::Package
  title 'TAC Fuel Balancer'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2013/12/TacFuelBalancer_2.3.0.2.zip'

  def install
    merge_directory 'GameData'
  end
end
