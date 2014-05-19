class KerbalAlarmClock < Kosmos::Package
  title 'Kerbal Alarm Clock'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2014/04/KerbalAlarmClock_2.7.3.0.zip'

  def install
    merge_directory 'KerbalAlarmClock_2.7.3.0/GameData'
  end
end
