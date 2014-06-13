class DownUnderAerospacePartySuppliesContinued < Kosmos::Package
  title 'Down Under Aerospace'
  url 'https://www.mediafire.com/?jv0ow5aj5b31kij'

  def install
    merge_directory 'DownUnder', into: 'GameData'
  end
end

