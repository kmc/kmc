module Kmc
  class Versioner
    class << self
      INIT_COMMIT_MESSAGE = "INIT: Initialize KMC"

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

        postinstalls = commits.select(&:post?).map(&:subject)
        uninstalls = commits.select(&:uninstall?).map(&:subject)

        # The packages that have actually been installed are those that have a
        # 'post-install' without any corresponding 'uninstall'. We can find
        # these packages by getting post-installs, and removing the first
        # instance of each package also found in uninstall.
        #
        # Note that we can't use Array#delete because that method will delete
        # *all* instances of a package, which won't work because it's possible
        # for a user to install, uninstall, then re-install a package.
        uninstalls.each do |package|
          postinstalls.delete_at(postinstalls.index(package))
        end

        postinstalls.map { |package_title| Package.find(package_title) }
      end

      # Has this package already been installed?
      def already_installed?(path, package)
        installed_packages(path).include?(package)
      end

      def uninstall_package(path, package)
        to_revert = GitAdapter.list_commits(path).find do |commit|
          commit.post? && commit.subject == package.title
        end

        GitAdapter.revert_commit(path, to_revert)
        Util.run_post_processors!(path)
        GitAdapter.commit_everything(path, uninstall_message(package))
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
