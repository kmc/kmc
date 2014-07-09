class RoverWheelSounds < Kosmos::Package
  title 'Rover Wheel Sounds'
  url 'http://kerbal.curseforge.com/ksp-mods/221310-rover-wheel-sounds'

  def install
    merge_directory 'GameData'
  end
end

