require 'nokogiri'

module Kosmos
  class DownloadUrl
    attr_reader :url

    def initialize(url)
      @url = url

      if curseforge?
        @url = "#{url}/files/latest"
      end
    end

    def resolve_download_url
      html = Nokogiri::HTML(rendered_html)

      if mediafire?
        html.css('.download_link a').first['href']
      elsif dropbox?
        html.css('#default_content_download_button').first['href']
      elsif curseforge?
        html.text.strip
      end
    end

    def mediafire?
      url =~ /mediafire/
    end

    def dropbox?
      url =~ /dropbox/
    end

    def curseforge?
      url =~ /curseforge/
    end

    private

    def rendered_html
      Dir.chdir(File.dirname(__FILE__)) do
        `phantomjs page_fetcher.js #{url}`
      end
    end
  end
end
