class HGRNewsphericalpodavailable < Kosmos::Package
  title 'Home Grown Rocket Parts'
  aliases 'home grown rockets'
  url 'http://www.mediafire.com/download/a3tf4mucsdvu29q/HGR.zip'

  def install
    merge_directory 'HexCans-0.5.1/GameData', into: 'GameData'
  end
end

