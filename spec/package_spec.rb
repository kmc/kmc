require 'spec_helper'

class ExamplePackage < Kmc::Package
  title 'Example'
  aliases 'specimen', 'illustration'

  url 'http://www.example.com/releases/release-0-1.zip'
end

class AnotherExample < Kmc::Package
  title 'Another Example'
  prerequisites 'example'
  postrequisites 'yet another'
end

class YetAnotherExample < Kmc::Package
  title 'Yet Another'
end

describe Kmc::Package do
  let(:example_url) { 'http://www.example.com/releases/release-0-1.zip' }

  subject { ExamplePackage }

  it 'has a full name' do
    expect(subject.title).to eq 'Example'
  end

  it 'resolves requisites' do
    expect(AnotherExample.resolve_prerequisites).to eq [ExamplePackage]
    expect(AnotherExample.resolve_postrequisites).to eq [YetAnotherExample]
  end

  describe 'downloading' do
    before do
      FakeFS.activate!

      File.open(File.join(Dir.home, '.kmc'), 'w') do |file|
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
      subject.download_and_unzip!
    end

    it 'falls back to http if no scheme specified' do
      ExamplePackage.url schemeless_url

      download_file = subject.download!
      expect(File.read(download_file)).to eq example_zip
    end
  end

  describe '#normalize_for_find' do
    it 'converts all to lowercase' do
      expect(Kmc::Package.normalize_for_find('eXaMpLe')).to eq 'example'
    end

    it 'converts spaces to dashes' do
      expect(Kmc::Package.normalize_for_find('many words')).
        to eq 'many-words'
    end

    it 'converts multiple spaces/dashes to one dash' do
      expect(Kmc::Package.normalize_for_find('hello - there')).
        to eq 'hello-there'
    end
  end

  describe '#find' do
    it 'finds a package by name' do
      expect(Kmc::Package.find('Example')).to eq ExamplePackage
    end

    it 'finds a package by alias' do
      expect(Kmc::Package.find('specimen')).to eq ExamplePackage
    end
  end

  describe '#search' do
    it 'finds packages with a similar name' do
      class PackageA < Kmc::Package; title 'Package A'; end
      class PackageB < Kmc::Package; title 'Package B'; aliases 'thing b'; end

      expect(Kmc::Package.search('pakcage a')).to eq PackageA
      expect(Kmc::Package.search('thign b')).to eq PackageB
    end
  end
end
