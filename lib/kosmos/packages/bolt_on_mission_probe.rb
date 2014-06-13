class BoltOnMissionProbe < Kosmos::Package
  title 'Bolt-On Mission Probe'
  url 'https://github.com/jinks/BOMPs/releases/download/v0.23.5/BOMPs-0.23.5.zip'

  def install
    merge_directory 'GameData'
  end
end

