class AutoAsparagus < Kosmos::Package
  title 'AutoAsparagus'
  url 'https://github.com/henrybauer/AutoAsparagus/releases/download/v0.5/AutoAsparagus-v0.5.zip'
  prerequisites 'toolbar'

  def install
    merge_directory 'AutoAsparagus', into: 'GameData'
  end
end
