class RealChute < Kosmos::Package
  title 'RealChute Parachute Systems'
  aliases 'realchute', 'real chute'
  url 'http://www.mediafire.com/download/5o7mc1cv25wtqkz/RealChute+v1.1.0.1.zip'

  def install
    merge_directory 'GameData'
  end
end
