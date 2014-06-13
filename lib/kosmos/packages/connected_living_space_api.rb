class ConnectedLivingSpaceAPI < Kosmos::Package
  title 'Connected Living Space (API)'
  url 'https://github.com/codepoetpbowden/ConnectedLivingSpace/releases/download/v1.0.6.0/CLSv1.0.6.0.zip'

  def install
    merge_directory 'GameData'
  end
end

