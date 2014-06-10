module Kosmos
  module PackageDownloads
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
end
