require 'spec_helper'

describe Kosmos::Package do
  class ExamplePackage < Kosmos::Package
    homepage 'http://www.example.com/'
    url 'http://www.example.com/releases/release-0-1.tar'
  end

  subject { ExamplePackage.new }

  it 'has a homepage' do
    expect(subject.homepage).to eq 'http://www.example.com/'
  end

  it 'resolves the url as a uri' do
    expect(subject.uri).to eq URI(
      'http://www.example.com/releases/release-0-1.tar')
  end
end
