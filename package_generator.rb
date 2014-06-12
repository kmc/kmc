# An automated script that attempts to generate a package description for a mod
# requested on the GitHub issues for Kosmos.
#
# It has four major components to find a mod:
#
#   1. Identifying the forum URL for a mod.
#
#      This done using the GitHub API to find a package-request issue, then
#      searching the issue for a link to a bit.ly address pointing to the KSP
#      forums.
#
#   2. Identifying the download URL for a mod.
#
#      The tool looks through all the links of the first post of the forum and
#      chooses the most likely download link based on the href and text of the
#      link.
#
#      If no definitive link could be found, candidate ones are suggested to the
#      user, who has the final say.
#
#   3. Determining what directories to merge together.
#
#      The tool looks at a directory tree, and attempts to find a directory that
#      contains 'GameData'. If such a directory is found, then the installation
#      process is assummed to be simply merging that directory.
#
#      If in addition to 'GameData' other KSP top-level directories (e.g.
#      'Ships') are found, those are merged in as well.
#
#      If no 'GameData' is found, then it is assumed that the install process is
#      to merge everything into the 'GameData' directory. The first directory to
#      have multiple children is assumed to be the "top-level" directory, and is
#      merged into 'GameData'.
#
#   4. Generating reports about the generated installs.
#
#      Each generated package file is outputted into the 'results' directory,
#      and is created as an '.rb' file. Accompanying it is a '.txt' file
#      containing the following information:
#        - The GitHub issue for the package
#        - The forum link for the package
#        - The install link for the package
#        - A directory tree for the package after it's been unzipped.
#
# Evidently, this tool relies on a lot of common patterns with mod install
# processes. As such, any deviation from the norm will break this tool. Because
# of this brittleness, it is important that mods be tested (or at the very
# least, that reports be looked at) before committing them into the Kosmos git
# repository.

class String
  def undent
    gsub(/^.{#{slice(/^ +/).length}}/, '')
  end
end

require 'kosmos'
require 'octokit'
require 'uri'
require 'ostruct'
require 'colorize'
require 'active_support/all'

KOSMOS_GIT_REPO = 'ucarion/kosmos'
SKIP = 12 # for testing

def github_package_requests
  puts "Loading from GitHub ..."

  client = Octokit::Client.new(access_token: ENV['GITHUB_KEY'])

  client.list_issues(KOSMOS_GIT_REPO, labels: 'package-request',
    direction: 'asc')[SKIP..-1]
end

# To make the development process easier, this method will *yield* each
# processed issue as it goes, rather than return them all when it's done.
def package_request_pages
  github_package_requests.each do |issue|
    package_name = issue.title

    bitly_link = URI.extract(issue.body).find { |url| url.include?('bit.ly') }
    response = HTTParty.get(bitly_link)
    forum_url = response.request.last_uri.to_s
    forum_html = response.body

    yield OpenStruct.new(name: issue.title, forum_url: forum_url,
      forum_html: forum_html)
  end
end

def extract_download_url_from_forum(forum_html)
  def extract_using_downloadurl(candidate_links)
    download_link = candidate_links.find do |link|
      download_url = Kosmos::DownloadUrl.new(link['href'])

      download_url.has_known_resolver?
    end

    if download_link
      begin
        {
          pretty_url: download_link['href'],
          url: Kosmos::DownloadUrl.new(download_link['href']).resolve_download_url
        }
      rescue
        {pretty_url: download_link['href']}
      end
    end
  end

  def extract_using_link_text(candidate_links)
    download_link = candidate_links.find do |link|
      link.text.downcase.include?('download')
    end

    {url: download_link['href']} if download_link
  end

  page = Nokogiri::HTML(forum_html)

  first_post = page.css('.posts .content').first
  links = first_post.css('a')

  extract_using_downloadurl(links) || extract_using_link_text(links)
end

# This is very un-DRY (repeats a lot of Kosmos code), but I'll live with it.

def download_from_cache(name)
  cache_dir = Kosmos.cache_dir
  if cache_dir
    puts "looking for #{File.join(cache_dir, "#{name}.zip")}"
    cached_download = File.join(cache_dir, "#{name}.zip")

    File.read(cached_download) if File.file?(cached_download)
  end
end

def download_and_unzip_package(name, download_url)
  begin
    cache = download_from_cache(name)

    downloaded_file = if cache
      puts "Using cache."
      cache
    else
      puts "Proceeding to download."
      HTTParty.get(download_url)
    end
    tmpdir = Dir.mktmpdir

    download_file = File.new(File.join(tmpdir, 'download'), 'w+')
    download_file.write(downloaded_file)
    download_file.close

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

    # save to cache ...
    File.open(File.join(Kosmos.cache_dir, "#{name}.zip"), 'w') do |file|
      file.write downloaded_file
    end

    output_path
  rescue => e
    puts "There was an error when downloading.".red
    puts "Error: #{e.inspect}".red
    puts e.backtrace.join("\n").red

    nil
  end
end

def generate_installer(package, download_dir, download_url)
  def find_gamedata(download_dir)
    Dir["**/*"].find { |file| File.basename(file) == 'GameData' }
  end

  class_name = package.name.gsub(' ', '')
  url = download_url && (download_url[:pretty_url] || download_url[:url])

  p download_dir
  Dir.chdir(download_dir) do
    puts `tree -L 4`

    files = Dir["*"]
    subdirs = Dir["*/"]

    if gamedata = find_gamedata(download_dir)
      <<-EOS.undent
        class #{class_name} < Kosmos::Package
          title '#{package.name}'
          url '#{url}'

          def install
            merge_directory '#{gamedata}'
          end
        end
      EOS
    elsif subdirs.length == 1
      to_merge = subdirs.first[0...-1]
      <<-EOS.undent
        class #{class_name} < Kosmos::Package
          title '#{package.name}'
          url '#{url}'

          def install
            merge_directory '#{to_merge}', into: 'GameData'
          end
        end
      EOS
    end
  end
end

def make_report(underscored_name, forum_url, download_url = nil, dir_tree = nil)
  Dir.chdir('reports') do
    File.open("#{underscored_name}.txt", 'w') do |file|
      file.write <<-EOS.undent + dir_tree
        Forum url: #{forum_url}
        Download url: #{download_url}

        Tree:
      EOS
    end
  end
end

def make_installer(underscored_name, installer)
  Dir.chdir('reports') do
    File.open("#{underscored_name}.rb", 'w') do |file|
      file.write(installer)
    end
  end
end

index = SKIP
package_request_pages do |package|
  puts "[#{index}] Working on #{package.name} ..."
  index += 1

  underscored_name = package.name.gsub(' ', '_').underscore.gsub(/\W/, '')

  download_url = extract_download_url_from_forum(package.forum_html)

  if download_url
    puts "Found a download URL at: #{download_url.inspect}"

    download_dir = download_and_unzip_package(package.name, download_url[:url])

    if download_dir
      installer = generate_installer(package, download_dir, download_url)

      tree = Dir.chdir(download_dir) { `tree --charset=ASCII` }

      if installer
        puts "Got installer:"
        puts installer.yellow
        make_installer(underscored_name, installer)
      end

      make_report(underscored_name, package.forum_url, download_url, tree)
    else
      make_report(underscored_name, package.forum_url, download_url)
    end
  else
    puts "No download URL could be found."
    make_report(underscored_name, package.forum_url)
  end
end
