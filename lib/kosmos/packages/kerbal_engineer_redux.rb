class KerbalEngineerRedux < Kosmos::Package
  title 'Kerbal Engineer Redux'
  url 'http://kerbal.curseforge.com/plugins/220285-kerbal-engineer-redux'

  def install
    merge_directory 'Engineer', into: 'GameData'
  end
end
