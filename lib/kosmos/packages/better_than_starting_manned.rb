class BetterThanStartingManned < Kosmos::Package
  title 'Better Than Starting Manned'
  url 'http://www.mediafire.com/download/2u47fyvueaweax3/BTSM1-56.zip'

  def install
    merge_directory 'GameData'
  end
end

