class NovaPunch < Kosmos::Package
  title 'NovaPunch'
  aliases 'nova-punch'
  url 'http://www.mediafire.com/download/f79630tg10j20b9/NovaPunch2_04.zip'

  def install
    merge_directory 'GameData'
    merge_directory 'Ships'
  end
end
