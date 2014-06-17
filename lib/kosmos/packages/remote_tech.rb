class RemoteTech2 < Kosmos::Package
  title 'Remote Tech 2'
  url 'https://github.com/RemoteTechnologiesGroup/RemoteTech/releases/download/v1.4.0/RemoteTech-v1.4.0.zip'

  def install
    merge_directory 'GameData'
  end
end
