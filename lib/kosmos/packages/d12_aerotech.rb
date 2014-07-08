class D12Aerotech < Kosmos::Package
  title 'D12 Aerotech'
  aliases 'D12', 'D12Aerospace'
  url 'https://www.dropbox.com/s/8sobh5owvrnieuc/D12AerotechBeta1.zip'
  prerequisites 'b9-aerospace-pack'

  def install
    merge_directory 'GameData'
  end
end

