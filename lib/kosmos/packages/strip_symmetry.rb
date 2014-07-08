class StripSymmetry < Kosmos::Package
  title 'StripSymmetry'
  aliases 'Strip Symmetry'
  url 'https://www.dropbox.com/s/6wjk338ni8q3pu7/StripSymmetry_1.2.zip'

  def install
    merge_directory 'Gamedata/StripSymmetry', into: 'GameData'
  end
end

