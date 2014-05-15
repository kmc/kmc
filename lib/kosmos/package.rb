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
