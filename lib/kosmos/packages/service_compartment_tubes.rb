class ServiceCompartmentTubes < Kosmos::Package
  title '6S Service Compartment Tubes'
  aliases 'Service Compartment Tubes'
  url 'http://kerbal.curseforge.com/parts/220359-s-service-compartment-tubes'

  def install
    merge_directory 'NothkeSerCom', into: 'GameData'
    merge_directory 'Firespitter', into: 'GameData'
  end
end

