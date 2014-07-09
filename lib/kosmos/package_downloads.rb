module Kosmos
  module PackageDownloads
    # Downloads and unzips a package. This will call #download! on its own, and
    # will return the location where the package was downloaded to as a
    # Pathname.
    def self.download_and_unzip_package(package, opts = {})
      download_file = download_package(package, opts)
      output_path = Pathname.new(download_file.path).parent.to_s

      return output_path if package.do_not_unzip

      Util.log "Unzipping ..."

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

    # Downloads the zipfile for a package using its URL, unless a cached version
    # is found first. Uses DownloadUrl to intelligently resolve download URLs.
    #
    # Returns the file downloaded, which is created in a temp directory.
    def self.download_package(package, opts = {})
      download_uri, downloaded_file = fetch_package_file(package)

      save_to_cache(package, downloaded_file) if opts[:cache_after_download]

      download_to_tempdir(download_file_name(download_uri), downloaded_file)
    end

    private

    # Given a package, returns a two-entry array.
    #
    # The first entry is a String uri pointing to where the file was fetched
    # from (either the filesystem or a website), and the second entry is the
    # contents of the download.
    def self.fetch_package_file(package)
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
    def self.cache_file(package)
      if Kosmos.cache_dir
        cache_file = File.join(Kosmos.cache_dir, "#{package.title}.zip")

        File.file?(cache_file) && cache_file
      end
    end

    def self.resolve_download_url(package)
      DownloadUrl.new(package.url).resolve_download_url
    end

    # Writes a downloaded package to the cache.
    #
    # This method assumes `Kosmos.cache_dir` already exists.
    def self.save_to_cache(package, downloaded_file)
      Util.log "Saving #{package.title} to cache ..."

      cache_location = File.join(Kosmos.cache_dir, "#{package.title}.zip")
      File.open(cache_location, 'wb+') do |file|
        file.write(downloaded_file)
      end
    end

    # Converts a string URI into the file name a downloaded file should be
    # placed into.
    def self.download_file_name(uri)
      # Remove non-alphanumeric characters to ensure a valid URI.
      clean_uri = uri.gsub(/[^[:alnum:]]/, '')

      File.basename(URI(clean_uri).path)
    end

    # Places `file_contents` into a file called `file_name` in a temporary
    # directory.
    def self.download_to_tempdir(file_name, file_contents)
      tmpdir = Dir.mktmpdir

      file = File.new(File.join(tmpdir, file_name), 'wb+')
      file.write(file_contents)
      file.close

      file
    end
  end
end
