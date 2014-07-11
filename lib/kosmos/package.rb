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
        return if Versioner.already_installed?(ksp_path, self)

        Util.log "Installing package #{self.title}"
        prepare_for_install(ksp_path, caveats)

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

      # Run steps that take place before installation.
      def prepare_for_install(ksp_path, caveats)
        add_caveat_message!(caveats)
        @ksp_path = ksp_path
        install_prerequisites!(caveats)
        @download_dir = download_and_unzip!
      end

      def add_caveat_message!(caveats)
        if method_defined?(:caveats)
          caveats.merge!(self => self.new.caveats)
        end
      end

      def install_prerequisites!(caveats)
        resolve_prerequisites.each do |package|
          unless Versioner.already_installed?(ksp_path, package)
            Util.log "#{title} has prerequisite #{package.title}."
            package.install!(ksp_path, caveats)
          end
        end
      end

      def install_postrequisites!(caveats)
        resolve_postrequisites.each do |package|
          unless Versioner.already_installed?(ksp_path, package)
            Util.log "#{title} has postrequisite #{package.title}."
            package.install!(ksp_path, caveats)
          end
        end
      end

      def log_caveats(caveats)
        if caveats.any?
          Util.log "===> Caveats"

          caveats.each do |package, message|
            Util.log <<-EOS.undent
              Caveat from #{package.title}:
              #{message}
            EOS
          end
        end
      end

      def load_packages!
        Dir[File.join(Configuration.packages_path, '*.rb')].each do |file|
          require file
        end
      end

      def load_post_processors!
        processors_path = File.join(File.dirname(__FILE__), 'post_processors')
        Dir["#{processors_path}/*.rb"].each do |file|
          require file
        end
      end
    end

    load_packages!
    load_post_processors!
  end
end
