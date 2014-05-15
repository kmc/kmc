require 'pathname'
require 'zip'
require 'tmpdir'

module Kosmos
  class Package
    def homepage
      @@homepage
    end

    def uri
      @@uri
    end

    class << self
      def homepage(homepage)
        @@homepage = homepage
      end

      def url(url)
        @@uri = URI(url)
      end
    end

    def unzip!
      download_file = download!
      output_path = Pathname.new(download_file.path).parent.to_s

      Zip::File.open(download_file.path) do |zip_file|
        zip_file.each do |entry|
          puts "Extracting #{entry}: #{entry.name}"
          entry.extract(File.join(output_path, entry.name))
        end
      end

      output_path
    end

    def download!
      response = Net::HTTP.get_response(uri)
      tmpdir = Dir.mktmpdir

      download_file = File.new(File.join(tmpdir, 'download'), 'w+')
      download_file.write(response.body)
      download_file.close

      download_file
    end
  end
end
