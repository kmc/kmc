class MechJeb < Kosmos::Package
  title 'MechJeb'
  url 'http://addons.cursecdn.com/files/2201/514/MechJeb2-2.2.1.0.zip'

  def install
    merge_directory 'MechJeb2', into: 'GameData'
  end
end
