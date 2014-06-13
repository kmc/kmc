class AutoAsparagus < Kosmos::Package
  title 'AutoAsparagus'
  url 'http://kerbal.curseforge.com/plugins/220452-autoasparagus'

  def install
    merge_directory 'GameData'
  end
end

