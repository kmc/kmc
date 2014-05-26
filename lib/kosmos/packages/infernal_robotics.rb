class InfernalRobotics < Kosmos::Package
  title 'Infernal Robotics'
  url 'http://www.mediafire.com/download/s2dt1etqquxti17/InfernalRobotics0.15d.zip'

  def install
    merge_directory 'GameData'
  end
end
