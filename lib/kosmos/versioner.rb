require 'rugged'

module Kosmos
  class Versioner
    class << self
      INIT_COMMIT_MESSAGE = "INIT: Initialize Kosmos"

      def init_repo(path)
        GitAdapter.init_repo(path)
        GitAdapter.commit_all(path, INIT_COMMIT_MESSAGE)
      end

      def mark_preinstall(path, package)
        GitAdapter.commit_everything(path, pre_install_message(package))
      end

      def mark_postinstall(path, package)
        GitAdapter.commit_everything(path, post_install_message(package))
      end

      def installed_packages(path)
        commits = GitAdapter.list_commits(path)
        installs = commits.select { |c| commit_type(c) == :post }
        installs.map { |c| commit_subject(c) }
      end

      private

      def pre_install_message(package)
        "PRE: #{package.title}"
      end

      def post_install_message(package)
        "POST: #{package.title}"
      end

      def commit_type(commit)
        # "POST: Example" --> :post
        commit.message.scan(/\A(\w+):/).first.first.downcase.to_sym
      end

      def commit_subject(commit)
        # "POST: Example" --> "Example"
        commit.message.split(' ')[1..-1].join(' ')
      end
    end
  end
end
