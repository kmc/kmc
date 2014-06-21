module Kosmos
  module PackageDownloads
    # Downloads and unzips a package. This will call #download! on its own, and
    # will return the location where the package was downloaded to as a
    # Pathname.
    def self.download_and_unzip_package(package, opts = {})
      download_file = download_package(package, opts)

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

    # Downloads the zipfile for a package using its URL, unless a cached version
    # is found first. Uses DownloadUrl to intelligently resolve download URLs.
    #
    # Returns the file downloaded, which is created in a temp directory.
    def self.download_package(package, opts = {})
      cached_download = download_from_cache(package)
      downloaded_file = if cached_download
        Util.log "Use a cached version of #{package.title} ..."
        cached_download
      else
        Util.log "The package is found at #{package.url}. "\
          "Finding the download URL ..."
        download_url = DownloadUrl.new(package.url).resolve_download_url

        Util.log "Found it. Downloading from #{download_url} ..."
        HTTParty.get(download_url)
      end

      save_to_cache(package, downloaded_file) if opts[:cache_after_download]

      tmpdir = Dir.mktmpdir

      download_file = File.new(File.join(tmpdir, 'download'), 'wb+')
      download_file.write(downloaded_file)
      download_file.close

      download_file
    end

    private

    def self.download_from_cache(package)
      cache_dir = Kosmos.cache_dir
      if cache_dir
        cached_download = File.join(cache_dir, "#{package.title}.zip")

        File.read(cached_download) if File.file?(cached_download)
      end
    end

    def self.save_to_cache(package, downloaded_file)
      Util.log "Saving #{package.title} to cache ..."

      cache_dir = Kosmos.cache_dir
      if cache_dir
        File.open(File.join(cache_dir, "#{package.title}.zip"), 'wb+') do |file|
          file.write(downloaded_file)
        end
      end
    end
  end
end
