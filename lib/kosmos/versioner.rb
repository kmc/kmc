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
        installs = commits.select { |c| commit_type(c) == :post }
        installs.map { |c| commit_subject(c) }
      end

      def uninstall_last_package(path)
        # Exclude current commit because if we're currently on a preinstall
        # commit (because we just uninstalled something else), then we wouldn't
        # actually do anything if we resetted to HEAD.
        #
        # We want to rewind to the last precommit that *does* have a matching
        # post-commit, that is, we want to undo the last postcommit.
        all_commits = GitAdapter.list_commits(path)
        candidate_commits = all_commits[1..-1]

        target = candidate_commits.find { |c| commit_type(c) == :pre }
        next_commit = all_commits[all_commits.index(target) - 1]

        verify_can_reset_to(target, next_commit)

        GitAdapter.reset_to_commit(path, target.oid)
        commit_subject(target)
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

      def verify_can_reset_to(target, next_commit)
        unless target && next_commit &&
            commit_type(next_commit) == :post &&
            commit_subject(target) == commit_subject(next_commit)
          raise InvalidUninstallError
        end
      end
    end
  end
end
