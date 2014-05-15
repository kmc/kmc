require 'spec_helper'

describe Kosmos::Versioner do
  let(:ksp_dir) { 'spec/fixtures/ksp' }

  after(:each) do
    FileUtils.rm_rf(File.join(ksp_dir, '.git'))
  end

  describe '#init_repo' do
    it 'creates a bare git repo and commits the tree' do
      Kosmos::Versioner.init_repo(ksp_dir)

      Dir.chdir(ksp_dir) do
        expect(`git ls-files --modified`).to be_empty
      end
    end
  end
end
