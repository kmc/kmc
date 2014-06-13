class AviationLights < Kosmos::Package
  title 'Aviation Lights'
  url 'http://www.mediafire.com/download/x1v4wfi6bl2tllu/Aviation_Lights_v3.6.zip'

  def install
    merge_directory 'GameData'
  end
end

