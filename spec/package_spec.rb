require 'spec_helper'

class ExamplePackage < Kosmos::Package
  homepage 'http://www.example.com/'
  url 'http://www.example.com/releases/release-0-1.tar'
end


describe Kosmos::Package do
  let(:example_homepage) { 'http://www.example.com/' }
  let(:example_url) { 'http://www.example.com/releases/release-0-1.tar' }

  subject { ExamplePackage.new }

  it 'has a homepage' do
    expect(subject.homepage).to eq example_homepage
  end

  it 'resolves the url as a uri' do
    expect(subject.uri).to eq URI(example_url)
  end

  describe 'downloading' do
    before do
      stub_request(:get, example_url).to_return(body: 'example')
    end

    it 'downloads from the url' do
      download_file = subject.download!
      expect(File.read(download_file)).to eq 'example'
    end
  end
end
