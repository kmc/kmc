class KerbQuake < Kosmos::Package
  title 'KerbQuake'
  url 'https://www.dropbox.com/s/mkz1rny3rr0iqfh/KerbQuake1.21.zip'

  def install
    merge_directory 'GameData'
  end
end
