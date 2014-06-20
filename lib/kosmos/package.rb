require 'pathname'
require 'httparty'
require 'zip'
require 'tmpdir'
require 'damerau-levenshtein'

module Kosmos
  class Package
    include PackageDsl
    include PackageAttrs

    attr_reader :ksp_path, :download_dir

    # Internal version of the `install` method, which handles procedures commong
    # to all packages, such as saving work before and after installation, as
    # well as downloading and unzipping packages and running post-processors.
    def install!(ksp_path)
      install_prerequisites!(ksp_path)

      @ksp_path = ksp_path
      @download_dir = self.class.unzip!

      Util.log "Saving your work before installing ..."
      Versioner.mark_preinstall(ksp_path, self.class)

      Util.log "Installing #{self.class.title} ..."
      install

      Util.log "Cleaning up ..."
      Util.run_post_processors!(ksp_path)

      Versioner.mark_postinstall(ksp_path, self.class)

      install_postrequisites!(ksp_path)
    end

    class << self
      def unzip!
        PackageDownloads.download_and_unzip_package(self)
      end

      def download!
        PackageDownloads.download_package(self)
      end

      # a callback for when a subclass of this class is created
      def inherited(package)
        (@@packages ||= []) << package
      end

      def normalize_for_find(name)
        name.downcase.gsub(' ', "-")
      end

      def normalized_title
        normalize_for_find(title)
      end

      def find(name)
        @@packages.find do |package|
          package.names.any? do |candidate_name|
            normalize_for_find(candidate_name) == normalize_for_find(name)
          end
        end
      end

      def search(name)
        @@packages.min_by do |package|
          package.names.map do |candidate_name|
            DamerauLevenshtein.distance(name, candidate_name)
          end.min
        end
      end

      def resolve_prerequisites
        prerequisites.map { |package_name| find(package_name) }
      end

      def resolve_postrequisites
        postrequisites.map { |package_name| find(package_name) }
      end
    end

    private

    def install_prerequisites!(ksp_path)
      self.class.resolve_prerequisites.each do |package|
        Util.log "#{title} has prerequisite #{package.title}."
        package.new.install!(ksp_path)
      end
    end

    def install_postrequisites!(ksp_path)
      self.class.resolve_postrequisites.each do |package|
        Util.log "#{title} has postrequisite #{package.title}."
        package.new.install!(ksp_path)
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
