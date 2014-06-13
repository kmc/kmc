class CoffeeIndustriesModularAirliner < Kosmos::Package
  title 'Coffee Industries - Modular Airliner'
  url 'https://dl.dropboxusercontent.com/u/64940561/%5B0.23.x%5D_ModularPlane_V2.1.1.zip'

  def install
    merge_directory 'ModulePlane/GameData'
  end
end

