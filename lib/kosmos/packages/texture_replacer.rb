class TextureReplacer < Kosmos::Package
  title 'Texture Replacer'
  url 'http://kerbal.curseforge.com/ksp-mods/220217-texturereplacer'

  def install
    merge_directory 'GameData'
  end
end
