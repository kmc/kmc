module Kmc
  module PackageDownloads
    class << self
      # Downloads and unzips a package. This will call #download! on its own, and
      # will return the location where the package was downloaded to as a
      # Pathname.
      def download_and_unzip_package(package, opts = {})
        download_file = download_package(package, opts)
        output_path = Pathname.new(download_file.path).parent.to_s

        return output_path if package.do_not_unzip

        Util.log "Unzipping ..."
        unzip_file(download_file.path, output_path)

        File.delete(File.absolute_path(download_file))

        output_path
      end

      # Downloads the zipfile for a package using its URL, unless a cached version
      # is found first. Uses DownloadUrl to intelligently resolve download URLs.
      #
      # Returns the file downloaded, which is created in a temp directory.
      def download_package(package, opts = {})
        download_uri, downloaded_file = fetch_package_file(package)

        save_to_cache(package, downloaded_file) if opts[:cache_after_download]

        download_to_tempdir(download_file_name(download_uri), downloaded_file)
      end

      def unzip_file(zipfile_path, output_path)
        Zip::File.open(zipfile_path) do |zip_file|
          zip_file.each do |entry|
            destination = File.join(output_path, entry.name)
            parent_dir = File.expand_path('..', destination)

            FileUtils.mkdir_p(parent_dir) unless File.exists?(parent_dir)

            entry.extract(destination)
          end
        end
      end

      # Places `file_contents` into a file called `file_name` in a temporary
      # directory.
      def download_to_tempdir(file_name, file_contents)
        tmpdir = Dir.mktmpdir

        file = File.new(File.join(tmpdir, file_name), 'wb+')
        file.write(file_contents)
        file.close

        file
      end

      private

      # Given a package, returns a two-entry array.
      #
      # The first entry is a String uri pointing to where the file was fetched
      # from (either the filesystem or a website), and the second entry is the
      # contents of the download.
      def fetch_package_file(package)
        cache = cache_file(package)
        if cache
          Util.log "Using a cached version of #{package.title} ..."

          [cache, File.read(cache)]
        else
          Util.log "The package is found at #{package.url}."
          Util.log "Finding the download URL ..."

          download_uri = resolve_download_url(package)

          Util.log "Found it. Downloading from #{download_uri} ..."
          [download_uri, HTTParty.get(download_uri)]
        end
      end

      # Returns the location of the cached version of a package, or some falsy
      # value if no such file exists.
      def cache_file(package)
        if Kmc::Configuration.cache_dir
          cache_file = File.join(Kmc::Configuration.cache_dir,
            "#{package.title}.zip")

          File.file?(cache_file) && cache_file
        end
      end

      def resolve_download_url(package)
        DownloadUrl.new(package.url).resolve_download_url
      end

      # Writes a downloaded package to the cache.
      #
      # This method assumes `Kmc.cache_dir` already exists.
      def save_to_cache(package, downloaded_file)
        Util.log "Saving #{package.title} to cache ..."

        cache_location = File.join(Kmc.cache_dir, "#{package.title}.zip")
        File.open(cache_location, 'wb+') do |file|
          file.write(downloaded_file)
        end
      end

      VALID_CHARS = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" +
          "0123456789-._~:/?#[]@!$&'()*+,;=").chars

      # Converts a string URI into the file name a downloaded file should be
      # placed into.
      def download_file_name(uri)
        # Remove invalid characters to ensure a valid URI.
        clean_uri = uri.chars.select { |char| VALID_CHARS.include?(char) }.join

        File.basename(URI(clean_uri).path)
      end
    end
  end
end
