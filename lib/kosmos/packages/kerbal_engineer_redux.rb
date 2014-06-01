class KerbalEngineerRedux < Kosmos::Package
  title 'Kerbal Engineer Redux'
  aliases 'ker'
  url 'http://kerbal.curseforge.com/plugins/220285-kerbal-engineer-redux'

  def install
    merge_directory 'Engineer', into: 'GameData'
  end
end

class KerbalEngineerReduxPatch < Kosmos::Package
  title 'Kerbal Engineer Redux - Patch for KSP 0.23.5'
  aliases 'ker patch', 'kerbal engineer redux patch'
  url 'https://www.dropbox.com/s/2b1d225vunp55ko/kerdlls.zip'

  def install
    merge_directory '.', into: 'GameData/Engineer'
  end
end
