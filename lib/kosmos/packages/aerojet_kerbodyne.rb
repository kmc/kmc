class AerojetKerbodyne < Kosmos::Package
  title 'Aerojet Kerbodyne'
  url 'https://www.dropbox.com/s/369uwom0bspo1x8/AerojetKerbodyne1.1.zip'

  def install
    merge_directory 'GameData'
  end
end

