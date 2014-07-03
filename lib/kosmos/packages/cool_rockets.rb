class CoolRockets < Kosmos::Package
  title 'CoolRockets'
  url 'https://dl.dropboxusercontent.com/u/3061183/CoolRockets%200.5.zip'

  def install
    merge_directory 'GameData'
  end
end
