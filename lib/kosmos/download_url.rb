module Kosmos
  class DownloadUrl
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def mediafire?
      url =~ /mediafire\.com/
    end

    def box?
      url =~ /box\.com/
    end

    def dropbox?
      url =~ /dropbox/
    end
  end
end
