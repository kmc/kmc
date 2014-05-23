class TACFuelBalancer < Kosmos::Package
  title 'TAC Fuel Balancer'
  url 'https://github.com/taraniselsu/TacFuelBalancer/releases/download/Release_v2.3/TacFuelBalancer_2.3.0.2.zip'

  def install
    merge_directory 'GameData'
  end
end
