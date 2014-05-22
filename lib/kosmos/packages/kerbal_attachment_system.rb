class KerbalAttachmentSystem < Kosmos::Package
  title 'Kerbal Attachment System'
  aliases 'kas'
  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2014/04/KAS_v0.4.7.zip'

  def install
    merge_directory 'GameData'
  end
end
