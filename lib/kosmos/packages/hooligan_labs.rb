class HooliganLabsAirships < Kosmos::Package
  title 'Hooligan Labs Airships'
  url 'http://kerbal.curseforge.com/ksp-mods/220395-hl-airships-v2-6-for-ksp-0-23-5'

  def install
    merge_directory 'GameData'
  end
end

class HooliganLabsSubmarines < Kosmos::Package
  title 'Hooligan Labs Submarines'
  url 'http://kerbal.curseforge.com/ksp-mods/220397-hl-submarines-v1-3-for-ksp-0-23-5'

  def install
    merge_directory 'GameData'
  end
end

class HooliganLabsSquidLandingLegs < Kosmos::Package
  title 'Hooligan Labs - SQUID Landing Legs'
  url 'http://kerbal.curseforge.com/ksp-mods/220398-hl-squid-landing-legs-v1-5-1-for-ksp-0-23-5'

  def install
    merge_directory 'GameData'
  end
end
