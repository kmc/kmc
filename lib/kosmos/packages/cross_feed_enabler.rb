class CrossFeedEnabler < Kosmos::Package
  title 'CrossFeedEnabler'
  url 'https://github.com/NathanKell/CrossFeedEnabler/releases/download/v1/CrossFeedEnabler_v1.zip'

  def install
    merge_directory 'CrossFeedEnabler', into: 'GameData'
  end
end

