require 'spec_helper'

describe Kosmos::DownloadUrl do
  it 'detects mediafire links' do
    url = 'http://www.mediafire.com/download/some-random-stuff/whatever.zip'
    expect(Kosmos::DownloadUrl.new(url)).to be_mediafire
  end

  it 'detects box links' do
    url = 'https://app.box.com/s/some-random-stuff'
    expect(Kosmos::DownloadUrl.new(url)).to be_box
  end

  it 'detects dropbox links' do
    url = 'https://dl.dropboxusercontent.com/s/some-random-stuff'
    expect(Kosmos::DownloadUrl.new(url)).to be_dropbox
  end
end
