class ModularFuelTanks < Kosmos::Package
  title 'Modular Fuel Tanks'
  url 'http://taniwha.org/~bill/ModularFuelTanks_v5.0.3.zip'
  prerequisites 'module-manager'

  def install
    merge_directory 'ModularFuelTanks', into: 'GameData'
  end
end

