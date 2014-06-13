class Achievements < Kosmos::Package
  title 'Achievements'
  url 'http://blizzy.de/achievements/Achievements-1.6.0.zip'

  def install
    merge_directory 'Achievements-1.6.0/GameData'
  end
end
