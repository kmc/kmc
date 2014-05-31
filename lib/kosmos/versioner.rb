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

        preinstalls = commits.select(&:pre?).map(&:subject)
        uninstalls = commits.select(&:uninstall?).map(&:subject)

        preinstalls - uninstalls
      end

      def uninstall_package(path, package)
        to_revert = GitAdapter.list_commits(path).find do |commit|
          commit.post? && commit.subject == package.title
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
    end
  end
end
