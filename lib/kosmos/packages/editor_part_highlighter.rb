class EditorPartHighlighter < Kosmos::Package
  title 'Editor Part Highlighter'
  url 'https://bitbucket.org/xEvilReeperx/ksp-part-highlighter/downloads/KSP-0.23.5-EditorPartHighlighter.zip'

  def install
    merge_directory 'GameData'
  end
end

