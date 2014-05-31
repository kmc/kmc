class RemoteTech2 < Kosmos::Package
  title 'Remote Tech 2'
  url 'https://github.com/RemoteTechnologiesGroup/RemoteTech/releases/download/v1.3.3/RemoteTech-v1.3.3.zip'

  def install
    merge_directory 'GameData'
  end
end

class RemoteTech2Fixpack < Kosmos::Package
  title 'Remote Tech 2 - Fixpack for KSP 0.23.5'
  aliases 'remote tech 2 fixpack'
  url 'http://www.mediafire.com/download/dncc8qu44t30a90/RemoteTech2_2014.01.08.22.30.zip'

  def install
    merge_directory 'GameData'
  end
end
