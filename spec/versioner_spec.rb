require 'spec_helper'

describe Kosmos::Versioner do
  let(:sandbox_dir) { 'spec/sandbox' }
  let(:ksp_dir) { File.absolute_path(File.join(sandbox_dir, 'ksp')) }

  before(:each) { FileUtils.mkdir_p(ksp_dir) }
  after(:each) { FileUtils.rm_rf(sandbox_dir) }

  describe '#init_repo' do
    it 'creates a bare git repo and commits the tree' do
      Kosmos::Versioner.init_repo(ksp_dir)

      Dir.chdir(ksp_dir) do
        expect(`git ls-files --modified`).to be_empty
      end
    end
  end

  describe '#mark_preinstall' do
    it 'adds everything and commits' do
      Kosmos::Versioner.init_repo(ksp_dir)

      Dir.chdir(ksp_dir) do
        package = OpenStruct.new
        package.title = "Example"

        `touch hello.txt`
        Kosmos::Versioner.mark_preinstall(ksp_dir, package)

        expect(`git ls-files --others`).to be_empty
        expect(`git log -1 --pretty=%B`).to eq "PRE: Example\n"
      end
    end
  end

  describe '#mark-postinstall' do
    it 'adds everything and commits' do
      Kosmos::Versioner.init_repo(ksp_dir)

      Dir.chdir(ksp_dir) do
        package = OpenStruct.new
        package.title = "Example"

        `touch hello.txt`
        Kosmos::Versioner.mark_postinstall(ksp_dir, package)

        expect(`git ls-files --others`).to be_empty
        expect(`git log -1 --pretty=%B`).to eq "POST: Example\n"
      end
    end
  end
end
