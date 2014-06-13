class BobCatindSovietAmericanPacks < Kosmos::Package
  title 'BobCat Ind Soviet-American Packs'
  url 'http://www.mediafire.com/?v75377195a0qhhv'

  def install
    merge_directory 'Soviet Pack ver1.9.1b/GameData'
    merge_directory 'Soviet Pack ver1.9.1b/Ships'
    merge_directory 'Soviet Pack ver1.9.1b/Subassemblies'
  end
end
