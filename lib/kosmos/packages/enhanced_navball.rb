class EnhancedNavball < Kosmos::Package
  title 'Enhanced Navball'
  url 'http://kerbal.curseforge.com/plugins/220469-enhanced-navball-v1-2'

  def install
    merge_directory 'EnhancedNavBall/Plugins'
  end
end
