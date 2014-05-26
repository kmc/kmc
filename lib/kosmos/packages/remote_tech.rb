class RemoteTech2 < Kosmos::Package
  title 'Remote Tech 2'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2013/12/RemoteTech2_Release_1.3.3.zip'

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
