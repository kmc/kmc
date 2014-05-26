class MechJeb < Kosmos::Package
  title 'MechJeb'
  url 'http://kerbal.curseforge.com/plugins/220221-mechjeb'

  def install
    merge_directory 'MechJeb2', into: 'GameData'
  end
end
