require 'nokogiri'

module Kosmos
  class DownloadUrl < Struct.new(:url)
    def resolve_download_url
      if mediafire?
        extract_mediafire_url
      elsif box?
        extract_box_url
      elsif dropbox?
        extract_dropbox_url
      elsif curseforge?
        extract_curseforge_url
      else
        url
      end
    end

    def has_known_resolver?
      mediafire? || box? || dropbox? || curseforge?
    end

    def mediafire?
      url =~ /mediafire/
    end

    def box?
      url =~ /app\.box\.com/
    end

    def dropbox?
      url =~ /dropbox\.com/
    end

    def curseforge?
      url =~ /curseforge/
    end

    private

    def extract_mediafire_url
      rendered_page.css('.download_link a').first['href']
    end

    def extract_dropbox_url
      rendered_page.css('#default_content_download_button').first['href']
    end

    def extract_curseforge_url
      rendered_html("#{url}/files/latest").strip
    end

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

    def rendered_page(url = self.url)
      Nokogiri::HTML(rendered_html(url))
    end

    def rendered_html(url)
      Dir.chdir(File.dirname(__FILE__)) do
        `phantomjs page_fetcher.js #{url}`
      end
    end
  end
end
