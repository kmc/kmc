class VesselOrbitalInformationalDisplay < Kosmos::Package
  title 'VOID - Vessel Orbital Informational Display'
  aliases 'void'
  url 'http://ksp.hawkbats.com/VOID/VOID-0-12-0.zip'

  def install
    merge_directory 'GameData'
  end
end
