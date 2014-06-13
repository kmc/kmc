class AmbientLightAdjustment < Kosmos::Package
  title 'Ambient Light Adjustment'
  url 'http://blizzy.de/ambient-light/AmbientLightAdjustment-1.1.0.zip'

  def install
    merge_directory 'AmbientLightAdjustment-1.1.0/GameData'
  end
end

