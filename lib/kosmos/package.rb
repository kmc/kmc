require 'pathname'
require 'httparty'
require 'zip'
require 'tmpdir'
require 'damerau-levenshtein'

require_relative 'package_utils'

module Kosmos
  class Package
    include PackageDsl

    class << self
      include PackageAttrs, PackageUtils

      attr_reader :ksp_path, :download_dir, :do_not_unzip

      # Installs a list of packages, and outputs caveats when it's done.
      def install_packages!(ksp_path, packages)
        caveats = {}
        packages.each { |package| package.install!(ksp_path, caveats) }
        log_caveats(caveats)
      end

      # Internal version of the `install` method. Handles:
      #   * Pre- and post-requisites
      #   * Version control
      #   * Post-processors
      #   * Calling a package's #install method
      #   * Building up caveats
      #
      # The caveats argument is expected to be a hash going from Packages to
      # caveat messages and will be modified in-place.
      def install!(ksp_path, caveats)
        return if Versioner.installed_packages(ksp_path).include?(self.title)

        Util.log "Installing package #{self.title}"

        add_caveat_message!(caveats)

        @ksp_path = ksp_path

        install_prerequisites!(caveats)

        @download_dir = download_and_unzip!

        Util.log "Saving your work before installing ..."
        Versioner.mark_preinstall(ksp_path, self)

        Util.log "Installing #{title} ..."
        self.new.install

        Util.log "Cleaning up ..."
        Util.run_post_processors!(ksp_path)

        Versioner.mark_postinstall(ksp_path, self)

        Util.log "Done!"

        install_postrequisites!(caveats)
      end

      def download_and_unzip!
        PackageDownloads.download_and_unzip_package(self)
      end

      def download!
        PackageDownloads.download_package(self)
      end

      def do_not_unzip!
        @do_not_unzip = true
      end

      # a callback for when a subclass of this class is created
      def inherited(package)
        (@@packages ||= []) << package
      end

      def packages
        @@packages
      end

      private

      def add_caveat_message!(caveats)
        if method_defined?(:caveats)
          caveats.merge!(self => self.new.caveats)
        end
      end

      def install_prerequisites!(caveats)
        resolve_prerequisites.each do |package|
          unless Versioner.installed_packages(ksp_path).include?(package.title)
            Util.log "#{title} has prerequisite #{package.title}."
            package.install!(ksp_path, caveats)
          end
        end
      end

      def install_postrequisites!(caveats)
        resolve_postrequisites.each do |package|
          unless Versioner.installed_packages(ksp_path).include?(package.title)
            Util.log "#{title} has postrequisite #{package.title}."
            package.install!(ksp_path, caveats)
          end
        end
      end

      def log_caveats(caveats)
        if caveats.any?
          Util.log "===> Caveats"
          caveats.each do |package, message|
            Util.log "Caveat from #{package.title}:"
            Util.log message
            Util.log ""
          end
        end
      end
    end

    # Now, let's include all the known packages.
    Dir[File.join(File.dirname(__FILE__), 'packages', '*.rb')].each do |file|
      require file
    end

    # ... and the post-processors too.
    Dir[File.join(File.dirname(__FILE__), 'post_processors', '*.rb')].each do |file|
      require file
    end
  end
end
