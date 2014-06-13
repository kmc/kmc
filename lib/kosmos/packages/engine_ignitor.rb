class EngineIgnitor < Kosmos::Package
  title 'Engine Ignitor'
  url 'https://www.dropbox.com/s/yousr4nxflld9ra/EngineIgnitor%20V3.2.zip'

  def install
    merge_directory 'EngineIgnitor', into: 'GameData'
  end
end

