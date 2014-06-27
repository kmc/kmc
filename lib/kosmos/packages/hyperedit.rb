class Hyperedit < Kosmos::Package
  title 'Hyperedit'
  url 'http://www.kerbaltekaerospace.com/?download=hyperedit%2FHyperEdit-1.2.4.2_for-KSP-0.21.1%2B.zip'

  def install
    merge_directory 'GameData'
  end
end
