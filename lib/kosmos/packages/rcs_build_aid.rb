class RcsBuildAid < Kosmos::Package
  title 'RCS Build Aid'
  url 'http://kerbal.curseforge.com/ksp-mods/220602-rcs-build-aid'

  def install
    merge_directory 'RCSBuildAid', into: 'GameData'
  end
end
