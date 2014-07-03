class NearFuturePropulsion < Kosmos::Package
  title 'Near Future Propulsion'
  url 'https://nabaal.net/files/ksp/nertea/NearFuturePropulsion0_1_1.zip'

  def install
    merge_directory 'GameData'
  end
end

class NearFuturePropulsionLowDef < Kosmos::Package
  title 'Near Future Propulsion - Low Definition (512 x 512)'
  aliases 'near future propulsion - low def'
  url 'https://nabaal.net/files/ksp/nertea/NearFuturePropulsion0_1_1.zip'

  def install
    merge_directory 'GameData'
    merge_directory '_low/GameData/NearFuture', into: 'GameData'
  end
end