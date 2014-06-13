class GlowStrips < Kosmos::Package
  title 'GlowStrips'
  url 'http://kerbal.curseforge.com/ksp-mods/221036-glowstrips-v0-1'

  def install
    merge_directory 'GlowStrips', into: 'GameData'
  end
end

