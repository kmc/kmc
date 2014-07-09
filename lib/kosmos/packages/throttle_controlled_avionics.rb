class ThrottleControlledAvionics < Kosmos::Package
  title 'Throttle Controlled Avionics'
  url 'http://kerbal.curseforge.com/plugins/220667-throttle-controlled-avionics-1-3'

  def install
    merge_directory '1.3/GameData', into: '.'
  end
end

