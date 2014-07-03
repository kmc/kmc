require 'spec_helper'

describe Kosmos::DownloadUrl do
  it 'detects mediafire links' do
    url = 'http://www.mediafire.com/download/some-random-stuff/whatever.zip'
    expect(Kosmos::DownloadUrl.new(url)).to be_mediafire
  end

  it 'correctly resolves mediafire download urls' do
    url = 'file://' + File.absolute_path('spec/fixtures/example_mediafire.html')
    target_url = 'http://download1690.mediafire.com/qny71y9k6kvg/o6cbe03iitggj1p/B9+Aerospace+Pack+R4.0c.zip'

    expect(Kosmos::DownloadUrl.new(url).resolve_download_url).to eq target_url
  end

  it 'detects box links' do
    url = 'https://app.box.com/s/89skim2e3simjwmuof4c'
    expect(Kosmos::DownloadUrl.new(url)).to be_box
  end

  it 'correctly resolves box download urls' do
    url = 'https://app.box.com/s/89skim2e3simjwmuof4c'
    target_url = 'https://app.box.com/index.php?rm=box_download_shared_file&shared_name=89skim2e3simjwmuof4c&file_id=f_13860854981'

    stub_request(:get, url).
      to_return(body: File.read('spec/fixtures/example_box.html'))

    expect(Kosmos::DownloadUrl.new(url).resolve_download_url).to eq target_url
  end

  it 'detects dropbox links' do
    url = 'https://www.dropbox.com/s/some-random-stuff/whatever.zip'
    expect(Kosmos::DownloadUrl.new(url)).to be_dropbox
  end

  it 'correctly resolves dropbox download urls' do
    url = 'file://' + File.absolute_path('spec/fixtures/example_dropbox.com.html')
    target_url = 'https://dl.dropboxusercontent.com/s/od4kickxt92jpo2/BetterAtmosphereV4%5BREL%5D.zip?dl=1&token_hash=AAFn5emxuVXLw_RfjDgQs0Hn7-YZ-vejn3m8zLgOj2tTFA&expiry=1401095304'

    expect(Kosmos::DownloadUrl.new(url).resolve_download_url).to eq target_url
  end

  it 'correctly resolves direct dropbox links' do
    url = 'https://dl.dropboxusercontent.com/u/103148235/ImprovedChaseCamerav1.3.1.zip'
    expect(Kosmos::DownloadUrl.new(url).resolve_download_url).to eq url
  end

  it 'detects curseforge links' do
    url = 'http://kerbal.curseforge.com/plugins/123123-whatever'
    expect(Kosmos::DownloadUrl.new(url)).to be_curseforge
  end

  # This is commented out until I mock this out -- I don't want to send useless
  # queries to Curseforge.
  #
  # it 'correctly resolves curseforge download urls' do
  #   # TODO: Use VCR or something on this
  #   url = 'http://kerbal.curseforge.com/plugins/220207-hotrockets-particle-fx-replacement'
  #   target_url = 'http://addons.cursecdn.com/files/2201%5C918/HotRockets_7.1_Nazari.zip'

  #   expect(Kosmos::DownloadUrl.new(url).resolve_download_url).to eq target_url
  # end

  it 'just returns the url if no built-in tool available' do
    url = 'https://github.com/rbray89/ActiveTextureManagement/releases/download/3-1-basic/ActiveTextureManagement-Basic-3-1.zip'

    expect(Kosmos::DownloadUrl.new(url).resolve_download_url).to eq url
  end
end
