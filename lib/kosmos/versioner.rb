require 'rugged'

module Kosmos
  class Versioner
    class << self
      def init_repo(path)
        repo = Rugged::Repository.init_at(path)

        commit_everything(repo, "this is a test")
      end

      def prepare_for_install(path, formula)
        message = <<-EOS.undent
          Saving state before installing #{formula.title}.
        EOS

        commit_everything(repo(path), message)
      end

      def save_after_install(path, formula)
        message = <<-EOS.undent
          Saving state after having installed #{formula.title}.
        EOS

        commit_everything(repo(path), message)
      end

      def revert_to_preinstall(path, formula)
        repo = repo(path)
        index = repo.index

        previous_commit = repo.lookup(repo.head.target).parents.first
        previous_tree = previous_commit.tree

        index.read_tree(previous_tree)
        modified_tree = index.write_tree(repo)
        index.write

        message = <<-EOS.undent
          Uninstalling #{formula.title}.
        EOS

        make_commit(repo, modified_tree, message)
      end

      private

      def repo(path)
        Rugged::Repository.new(path)
      end

      def commit_everything(repo, message)
        index = repo.index

        Dir.chdir(repo.workdir) do
          Dir["**/*"].each do |path|
            stage_file(repo, index, path) unless File.directory?(path)
          end
        end

        # write changes to index into git database
        modified_tree = index.write_tree(repo)
        index.write

        make_commit(repo, modified_tree, message)
      end

      def stage_file(repo, index, path)
        index.add(path: path,
          oid: Rugged::Blob.from_workdir(repo, path),
          mode: 0100644)
      end

      def make_commit(repo, tree, message)
        Rugged::Commit.create(repo,
          author: commit_author,
          committer: commit_author,
          message: message,
          parents: repo.empty? ? [] : [repo.head.target],
          tree: tree,
          update_ref: 'HEAD')
      end

      def commit_author
        {name: "Kosmos", time: Time.now, email: "kosmos@example.com"}
      end
    end
  end
end
