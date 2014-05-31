class KerbalAttachmentSystem < Kosmos::Package
  title 'Kerbal Attachment System'
  aliases 'kas'
  url 'https://nabaal.net/files/ksp/KAS_v0.4.7.zip'

  def install
    merge_directory 'GameData'
  end
end
