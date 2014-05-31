require 'rugged'

module Kosmos
  class Versioner
    class << self
      INIT_COMMIT_MESSAGE = "INIT: Initialize Kosmos"

      def init_repo(path)
        GitAdapter.init_repo(path)
        GitAdapter.commit_everything(path, INIT_COMMIT_MESSAGE)
      end

      def mark_preinstall(path, package)
        GitAdapter.commit_everything(path, pre_install_message(package))
      end

      def mark_postinstall(path, package)
        GitAdapter.commit_everything(path, post_install_message(package))
      end

      def installed_packages(path)
        commits = GitAdapter.list_commits(path)

        preinstalls, uninstalls = [:pre, :uninstall].map do |type|
          commits.select { |c| commit_type(c) == type }.map do |commit|
            commit_subject(commit)
          end
        end

        preinstalls - uninstalls
      end

      def uninstall_package(path, package)
        to_revert = GitAdapter.list_commits(path).find do |commit|
          commit_type(commit) == :post &&
            commit_subject(commit) == package.title
        end

        GitAdapter.revert_commit(path, to_revert, uninstall_message(package))
      end

      private

      def pre_install_message(package)
        "PRE: #{package.title}"
      end

      def post_install_message(package)
        "POST: #{package.title}"
      end

      def uninstall_message(package)
        "UNINSTALL: #{package.title}"
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
