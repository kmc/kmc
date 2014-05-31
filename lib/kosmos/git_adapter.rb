require 'shellwords'

module Kosmos
  module GitAdapter
    class << self
      def init_repo(path)
        Dir.chdir(path) do
          `git init`
        end
      end

      def commit_everything(repo_path, commit_message)
        Dir.chdir(repo_path) do
          `git add -A -f`
          `git commit --allow-empty -m #{commit_message.shellescape}`
        end
      end

      def revert_commit(repo_path, commit, commit_message)
        Dir.chdir(repo_path) do
          `git revert --no-commit #{commit.sha}`
          `git add -A -f`
          `git commit --allow-empty -m #{commit_message.shellescape}`
        end
      end

      def list_commits(repo_path)
        Dir.chdir(repo_path) do
          `git log --oneline`.lines.map do |line|
            sha, message = line.split(' ', 2)
            Commit.new(message, sha)
          end
        end
      end
    end

    class Commit < Struct.new(:message, :sha)
    end
  end
end
