class EditorExtensions < Kosmos::Package
  title 'Editor Extensions'
  url 'https://github.com/MachXXV/EditorExtensions/blob/master/Releases/EditorExtensions_v1.1.zip?raw=true'

  def install
    merge_directory 'EditorExtensions', into: 'GameData'
  end
end

