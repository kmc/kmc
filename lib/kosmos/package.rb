require 'pathname'
require 'httparty'
require 'zip'
require 'tmpdir'
require 'damerau-levenshtein'

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

      Util.log "Saving your work before installing ..."
      Versioner.mark_preinstall(ksp_path, self.class)

      Util.log "Installing #{self.class.title} ..."
      install

      Util.log "Cleaning up ..."
      Util.run_post_processors!(ksp_path)

      Versioner.mark_postinstall(ksp_path, self.class)
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

      def names
        [title, aliases].flatten
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

      def unzip!
        download_file = download!

        Util.log "Unzipping ..."

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
        cached_download = download_from_cache
        downloaded_file = if cached_download
          Util.log "Use a cached version of #{title} ..."
          cached_download
        else
          Util.log "The package is found at #{url}. Finding the download URL ..."
          download_url = DownloadUrl.new(url).resolve_download_url

          Util.log "Found it. Downloading from #{download_url} ..."
          HTTParty.get(download_url)
        end

        tmpdir = Dir.mktmpdir

        download_file = File.new(File.join(tmpdir, 'download'), 'w+')
        download_file.write(downloaded_file)
        download_file.close

        download_file
      end

      private

      def download_from_cache
        cache_dir = Kosmos.cache_dir
        if cache_dir
          cached_download = File.join(cache_dir, "#{title}.zip")

          File.read(cached_download) if File.file?(cached_download)
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
