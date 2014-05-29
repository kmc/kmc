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
      return extract_box_url if box?
      return url unless has_known_resolver?

      raw_html = rendered_html

      page = Nokogiri::HTML(raw_html)

      if mediafire?
        page.css('.download_link a').first['href']
      elsif dropbox?
        page.css('#default_content_download_button').first['href']
      elsif curseforge?
        raw_html.strip
      end
    end

    def mediafire?
      url =~ /mediafire/
    end

    def box?
      url =~ /app\.box\.com/
    end

    def dropbox?
      url =~ /dropbox/
    end

    def curseforge?
      url =~ /curseforge/
    end

    private

    def extract_box_url
      raw_html = HTTParty.get(url)

      shared_name = url.split("/").last
      file_id = raw_html.scan(/itemTypedID: \"(f_\d+)\"/)[0][0]

      box_intermediate_url(shared_name, file_id)
    end

    def box_intermediate_url(shared_name, file_id)
      base = "https://app.box.com/index.php?rm=box_download_shared_file"
      shared_name_part = "&shared_name=#{shared_name}"
      file_id_part = "&file_id=#{file_id}"

      base + shared_name_part + file_id_part
    end

    def has_known_resolver?
      mediafire? || dropbox? || curseforge?
    end

    def rendered_html(url = self.url)
      Dir.chdir(File.dirname(__FILE__)) do
        `phantomjs page_fetcher.js #{url}`
      end
    end
  end
end
