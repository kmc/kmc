module Kosmos
  module GitAdapter
    class << self
      def init_repo(path)
        Rugged::Repository.init_at(path)
      end

      def commit_everything(repo_path, commit_message)
        repo = repo(repo_path)
        index = repo.index

        Dir.chdir(repo.workdir) do
          Dir["**/*"].each do |path|
            unless File.directory?(path)
              mode = File::Stat.new(path).mode
              stage_file(repo, index, path, mode)
            end
          end
        end

        commit_index(repo, index, commit_message)
      end

      def commit_changes(repo_path, commit_message)
        repo = repo(repo_path)
        index = repo.index
        head_tree = repo.lookup(repo.head.target).tree

        diff = repo.diff_workdir(head_tree,
          include_untracked: true, recurse_untracked_dirs: true)

        diff.each_delta do |delta|
          if delta.status == :deleted
            index.remove(delta.old_file[:path])
          else
            path = delta.new_file[:path]
            mode = File::Stat.new(File.join(repo_path, path)).mode

            stage_file(repo, index, path, mode)
          end
        end

        commit_index(repo, index, commit_message)
      end

      def reset_to_commit(repo_path, commit_oid)
        repo = repo(repo_path)
        repo.reset(repo.lookup(commit_oid), :hard)
      end

      def list_commits(repo_path)
        def parent_commits(commit)
          if commit
            [commit] + parent_commits(commit.parents.first)
          else
            []
          end
        end

        repo = repo(repo_path)
        head = repo.lookup(repo.head.target)
        parent_commits(head)
      end

      private

      def repo(path)
        Rugged::Repository.new(path)
      end

      def stage_file(repo, index, path, mode)
        index.add(path: path,
          oid: Rugged::Blob.from_workdir(repo, path), mode: mode)
      end

      def commit_index(repo, index, message)
        modified_tree = index.write_tree(repo)
        index.write

        make_commit(repo, modified_tree, message)
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
