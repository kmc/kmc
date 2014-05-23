require 'spec_helper'

describe Kosmos::Versioner do
  let(:sandbox_dir) { 'spec/sandbox' }
  let(:ksp_dir) { File.join(sandbox_dir, 'ksp') }

  before { FileUtils.mkdir_p(ksp_dir) }
  after { FileUtils.rm_rf(sandbox_dir) }

  describe '#init_repo' do
    it 'creates a bare git repo and commits the tree' do
      Kosmos::Versioner.init_repo(ksp_dir)

      Dir.chdir(ksp_dir) do
        expect(`git ls-files --modified`).to be_empty
      end
    end
  end
end
