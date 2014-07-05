class ALCORCapsule < Kosmos::Package
  title 'Advanced Landing Capsule for Orbital Rendezvous'
  aliases 'ALCOR', 'ALCOR Capsule'
  url 'http://www.mediafire.com/download/7h0q0e252tge774/ALCOR_Capsule_0.9.zip'
  prerequisites 'raster-prop-monitor'
  postrequisites 'alcor-iva-patch', 'alcor-props-pack'

  def install
    merge_directory 'Gamedata/ASET', into: 'GameData'
  end
end

class ALCORIVAPatch < Kosmos::Package
  title 'ALCOR IVA Patch'
  url 'http://www.mediafire.com/download/1iwml4q0mp7dn14/ALCOR_IVA_Patch_0.9.zip'

  def install
    merge_directory 'Gamedata/ASET', into: 'GameData'
  end
end

class ALCORPropsPack < Kosmos::Package
  title 'ALCOR Props Pack'
  url 'http://www.mediafire.com/download/lpvadcbobcj7dyv/ASET_Props_1.0.1.zip'

  def install
    merge_directory 'Gamedata/ASET', into: 'GameData'
  end
end

