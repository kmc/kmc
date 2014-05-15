require 'spec_helper'

class ExamplePackage < Kosmos::Package
  homepage 'http://www.example.com/'
  url 'http://www.example.com/releases/release-0-1.zip'
end


describe Kosmos::Package do
  let(:example_homepage) { 'http://www.example.com/' }
  let(:example_url) { 'http://www.example.com/releases/release-0-1.zip' }

  subject { ExamplePackage.new }

  it 'has a homepage' do
    expect(subject.homepage).to eq example_homepage
  end

  it 'resolves the url as a uri' do
    expect(subject.uri).to eq URI(example_url)
  end

  describe 'downloading' do
    let(:example_zip) { File.read('spec/fixtures/example.zip') }
    let(:redirected_url) { 'http://example.com/latest' }

    before do
      stub_request(:get, example_url).to_return(body: example_zip)
      stub_request(:get, redirected_url).
        to_return(status: 301, headers: {'Location' => example_url})

      ExamplePackage.url redirected_url
    end

    it 'downloads from the url' do
      download_file = subject.download!
      expect(File.read(download_file)).to eq example_zip
    end

    it 'unzips the contents' do
      unzipped_dir = subject.unzip!

      expect(Dir.entries(unzipped_dir)).to include('tmp')
      expect(File.read(File.join(unzipped_dir, 'tmp', 'example.txt'))).
        to eq "Hello, world!\n"
    end
  end
end
