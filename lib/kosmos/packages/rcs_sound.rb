class RCSSound < Kosmos::Package
  title 'RCS Sound'
  aliases 'RCS Sounds'
  url 'http://kerbal.curseforge.com/ksp-mods/220521-rcs-sounds'

  def install
    merge_directory 'GameData'
  end
end

