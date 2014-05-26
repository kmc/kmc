require 'nokogiri'

module Kosmos
  class DownloadUrl
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def resolve_download_url
      html = Nokogiri::HTML(rendered_html)

      if mediafire?
        html.css('.download_link a').first['href']
      end
    end

    def mediafire?
      url =~ /mediafire/
    end

    def box?
      url =~ /box\.com/
    end

    def dropbox?
      url =~ /dropbox/
    end

    private

    def rendered_html
      Dir.chdir(File.dirname(__FILE__)) do
        `phantomjs page_fetcher.js #{url}`
      end
    end
  end
end
