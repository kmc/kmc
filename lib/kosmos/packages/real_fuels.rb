class RealFuels < Kosmos::Package
  title 'Real Ruels'
  url 'https://github.com/NathanKell/ModularFuelSystem/releases/download/rf-v6.4/RealFuels_v6.4.zip'

  def install
    merge_directory 'RealFuels', into: 'GameData'
    merge_directory 'ModuleManager.2.1.5.dll', into: 'GameData'
  end
end
