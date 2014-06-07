class HullcamVDS < Kosmos::Package
  title 'Hullcam VDS'
  url 'http://kerbal.curseforge.com/ksp-mods/220258-hullcam-vds'

  def install
    merge_directory 'HullCameraVDS', into: 'GameData'
  end
end
