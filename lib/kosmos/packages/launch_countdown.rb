class LaunchCountDown < Kosmos::Package
  title 'Launch CountDown'
  url 'http://kerbal.curseforge.com/ksp-mods/220987-athlonic-electronics-lcd-launch-countdown-v1-7-1'

  def install
    merge_directory 'GameData'
  end
end

