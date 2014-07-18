require 'spec_helper'

describe Kmc::Versioner do
  let(:sandbox_dir) { 'spec/sandbox' }
  let(:ksp_dir) { File.absolute_path(File.join(sandbox_dir, 'ksp')) }

  before(:each) { FileUtils.mkdir_p(ksp_dir) }
  after(:each) { FileUtils.rm_rf(sandbox_dir) }

  describe '#init_repo' do
    it 'creates a bare git repo and commits the tree' do
      Kmc::Versioner.init_repo(ksp_dir)

      Dir.chdir(ksp_dir) do
        expect(`git ls-files --modified`).to be_empty
      end
    end
  end

  describe '#mark_preinstall' do
    it 'adds everything and commits' do
      Kmc::Versioner.init_repo(ksp_dir)

      Dir.chdir(ksp_dir) do
        package = OpenStruct.new(title: "Example")

        `touch hello.txt`
        Kmc::Versioner.mark_preinstall(ksp_dir, package)

        expect(`git ls-files --others`).to be_empty
        expect(`git log -1 --pretty=%B`.strip).to eq "PRE: Example"
      end
    end
  end

  describe '#mark-postinstall' do
    it 'adds everything and commits' do
      Kmc::Versioner.init_repo(ksp_dir)

      Dir.chdir(ksp_dir) do
        package = OpenStruct.new(title: "Example")

        `touch hello.txt`
        Kmc::Versioner.mark_postinstall(ksp_dir, package)

        expect(`git ls-files --others`).to be_empty
        expect(`git log -1 --pretty=%B`.strip).to eq "POST: Example"
      end
    end
  end

  describe '#installed-packages' do
    it 'gets all those with a post-install, but ignores just pre-installs' do
      Kmc::Versioner.init_repo(ksp_dir)

      %w(a b c).each do |title|
        package = Class.new(Kmc::Package) { title(title) }
        Kmc::Versioner.mark_preinstall(ksp_dir, package)
        Kmc::Versioner.mark_postinstall(ksp_dir, package)
      end

      package = Class.new(Kmc::Package) { title('d') }
      Kmc::Versioner.mark_preinstall(ksp_dir, package)

      installed_packages = Kmc::Versioner.installed_packages(ksp_dir)
      expect(installed_packages.map(&:title)).to eq %w(c b a)
    end
  end
end
