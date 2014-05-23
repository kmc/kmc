require 'pathname'
require 'httparty'
require 'zip'
require 'tmpdir'

module Kosmos
  class Package
    include PackageDsl

    attr_reader :ksp_path, :download_dir

    [:title, :url].each do |param|
      define_singleton_method(param) do |value = nil|
        if value
          instance_variable_set("@#{param}", value)
        else
          instance_variable_get("@#{param}")
        end
      end
    end

    # Internal version of the `install` method, which saves before actually
    # performing the installation.
    def install!(ksp_path)
      @ksp_path = ksp_path
      @download_dir = self.class.unzip!

      puts "Saving your work before installing ..." if Kosmos.config.verbose
      Versioner.mark_preinstall(ksp_path, self.class)

      puts "Installing #{self.class.title} ..." if Kosmos.config.verbose
      install
      puts "Cleaning up ..." if Kosmos.config.verbose
      Versioner.mark_postinstall(ksp_path, self.class)
      Kosmos.config.post_processors.each { |p| p.post_process(ksp_path) }
    end

    class << self
      def aliases(*aliases)
        @aliases ||= []

        if aliases.any?
          @aliases = aliases
        else
          @aliases
        end
      end

      # a callback for when a subclass of this class is created
      def inherited(package)
        (@@packages ||= []) << package
      end

      def normalize_for_find(name)
        name.downcase.gsub(' ', "-")
      end

      def find(name)
        @@packages.find do |package|
          [package.title, package.aliases].flatten.any? do |candidate_name|
            normalize_for_find(candidate_name) == normalize_for_find(name)
          end
        end
      end

      def unzip!
        download_file = download!

        puts "Unzipping ..." if Kosmos.config.verbose

        output_path = Pathname.new(download_file.path).parent.to_s

        Zip::File.open(download_file.path) do |zip_file|
          zip_file.each do |entry|
            destination = File.join(output_path, entry.name)
            parent_dir = File.expand_path('..', destination)

            FileUtils.mkdir_p(parent_dir) unless File.exists?(parent_dir)

            entry.extract(destination)
          end
        end

        File.delete(File.absolute_path(download_file))

        output_path
      end

      def download!
        puts "Downloading from #{url} ..." if Kosmos.config.verbose
        downloaded_file = HTTParty.get(url)

        tmpdir = Dir.mktmpdir

        download_file = File.new(File.join(tmpdir, 'download'), 'w+')
        download_file.write(downloaded_file)
        download_file.close

        download_file
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
