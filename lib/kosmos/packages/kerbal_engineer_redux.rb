class KerbalEngineerRedux < Kosmos::Package
  title 'Kerbal Engineer Redux'
  url 'http://addons.cursecdn.com/files/2201/929/Engineer%20Redux%20v0.6.2.4.zip'

  def install
    merge_directory 'Engineer', into: 'GameData'
  end
end
