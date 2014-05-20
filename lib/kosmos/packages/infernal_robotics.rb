class InfernalRobotics < Kosmos::Package
  title 'Infernal Robotics'
  url 'http://download873.mediafire.com/84o0x1260xxg/34ct48puesp1xfb/InfernalRobotics0.15b.zip'

  def install
    merge_directory 'GameData'
  end
end
