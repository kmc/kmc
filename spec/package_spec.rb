require 'spec_helper'

class ExamplePackage < Kosmos::Package
  title 'Example'
  aliases 'specimen', 'illustration'

  url 'http://www.example.com/releases/release-0-1.zip'
end

class AnotherExample < Kosmos::Package
  title 'Another Example'
  prerequisites 'example'
  postrequisites 'yet another'
end

class YetAnotherExample < Kosmos::Package
  title 'Yet Another'
end

describe Kosmos::Package do
  let(:example_url) { 'http://www.example.com/releases/release-0-1.zip' }

  subject { ExamplePackage }

  it 'has a full name' do
    expect(subject.title).to eq 'Example'
    expect(subject.new.title).to eq 'Example'
  end

  it 'resolves requisites' do
    expect(AnotherExample.resolve_prerequisites).to eq [ExamplePackage]
    expect(AnotherExample.resolve_postrequisites).to eq [YetAnotherExample]
  end

  describe 'downloading' do
    before do
      FakeFS.activate!

      File.open(File.join(Dir.home, '.kosmos'), 'w') do |file|
        file.write '{}'
      end
    end
    after { FakeFS.deactivate! }

    let(:example_zip) do
      Zip::File.open('example', Zip::File::CREATE) {}
      File.read('example')
    end

    let(:redirected_url) { 'http://example.com/latest' }
    let(:schemeless_url) { '//example.com/latest' }

    before do
      stub_request(:get, example_url).to_return(body: example_zip)
      stub_request(:get, redirected_url).
        to_return(status: 301, headers: {'Location' => example_url})

      ExamplePackage.url redirected_url
    end

    it 'downloads from the url' do
      download_file = subject.send(:download!)
      expect(File.read(download_file)).to eq example_zip
    end

    it 'unzips the contents' do
      Zip::File.should_receive(:open)
      subject.unzip!
    end

    it 'falls back to http if no scheme specified' do
      ExamplePackage.url schemeless_url

      download_file = subject.download!
      expect(File.read(download_file)).to eq example_zip
    end
  end

  describe '#normalize_for_find' do
    it 'converts all to lowercase' do
      expect(Kosmos::Package.normalize_for_find('eXaMpLe')).to eq 'example'
    end

    it 'converts spaces to dashes' do
      expect(Kosmos::Package.normalize_for_find('many words')).
        to eq 'many-words'
    end
  end

  describe '#find' do
    it 'finds a package by name' do
      expect(Kosmos::Package.find('Example')).to eq ExamplePackage
    end

    it 'finds a package by alias' do
      expect(Kosmos::Package.find('specimen')).to eq ExamplePackage
    end
  end

  describe '#search' do
    it 'finds packages with a similar name' do
      class PackageA < Kosmos::Package; title 'Package A'; end
      class PackageB < Kosmos::Package; title 'Package B'; aliases 'thing b'; end

      expect(Kosmos::Package.search('pakcage a')).to eq PackageA
      expect(Kosmos::Package.search('thign b')).to eq PackageB
    end
  end
end
