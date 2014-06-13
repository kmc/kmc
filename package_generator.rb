# An automated script that attempts to generate a package description for a mod
# requested on the GitHub issues for Kosmos.
#
# Initially this tool was going to generate entire package descriptions on its
# own, but this proved to be difficult to implement (largely due to highly non-
# standard install processes with many mods).
#
# This tool takes in GitHub issues, and churns out .rb template files with
# useful information about the package written in the comments.
#
# This script has three major components:
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
#   3. Creating the template file.
#
#      The appropriate name of the file is generated and placed into the
#      'reports' directory for human review.
#
#      This generated template file will already contain a class name, a title,
#      a url, and an empty `install` method.
#
#      The tool will also provide a `tree` of the files in the mod and the forum
#      URL of the mod.
#
# The heuristics for finding the correct download link are pretty iffy and break
# very often. In these cases, no `tree` can be provided.

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

Kosmos.configure do |config|
  config.verbose = true
end

KOSMOS_GIT_REPO = 'ucarion/kosmos'
SKIP = 3 # for testing

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

# Given the forum page, it will generate a hash with one of two possible keys:
#
#   :url -> Download directly from here. No known download resolvers.
#   :pretty_url -> Use a resolver on this link.
#
# Note the :pretty_url links might not always work because many common providers
# employ rate-limiting techniques. Also, a :url link might not always work
# because the link-text heuristic doesn't work well with indirection.
def extract_download_url_from_forum(forum_html)
  # Try to find download link using some heuristics for specific download
  # providers.
  def extract_using_downloadurl(candidate_links)
    download_link = candidate_links.find do |link|
      Kosmos::DownloadUrl.new(link['href']).has_known_resolver?
    end

    {pretty_url: download_link['href']} if download_link
  end

  # Try to find download link by looking for links with the word 'download' in
  # them (yes, it's pretty desperate).
  def extract_using_link_text(candidate_links)
    download_link = candidate_links.find do |link|
      link.text.downcase.include?('download')
    end

    {url: download_link['href']} if download_link
  end

  def possibly_outdated?(candidate_links)
    candidate_links.any? do |link|
      link.text.downcase.include?('kerbalspaceport')
    end
  end

  page = Nokogiri::HTML(forum_html)

  first_post = page.css('.posts .content').first
  links = first_post.css('a')

  (extract_using_downloadurl(links) || extract_using_link_text(links)).merge({
    outdated: possibly_outdated?(links)
  })
end

def package_file_name(name)
  name.gsub(' ', '').gsub(/\W/, '').underscore + '.rb'
end

def package_class_name(name)
  name = name.gsub(/\W/, '')
  name[0].upcase + name[1..-1]
end

def directory_tree(dir)
  tree = Dir.chdir(File.dirname(dir)) { `unzip -l download` }
  tree.split("\n").map { |l| "# " + l }.join("\n")
end

count = SKIP
package_request_pages do |package|
  puts "[#{count}] Working on #{package.name} ..."
  count += 1

  # The data to be generated in the template
  package_title, package_file_name, package_class_name, package_download_link,
    forum_url, tree, warning = nil

  package_title = package.name
  package_file_name = package_file_name(package.name)
  package_class_name = package_class_name(package.name)
  forum_url = package.forum_url

  begin
    download_link = extract_download_url_from_forum(package.forum_html)
    package_download_link = download_link[:pretty_url] || download_link[:url]

    download_dir = Kosmos::PackageDownloads.download_package(
      OpenStruct.new(title: package_title, url: package_download_link.strip),
      cache_after_download: true)

    warning = "Possibly outdated!" if download_link[:outdated]

    tree = directory_tree(download_dir)
  rescue => e
    puts <<-EOS.undent.red
      There was an error while processing #{package.name}.

      #{e}

      #{e.backtrace.join("\n" + " " * 16)}
    EOS
  end

  package_file = <<-EOS.undent + (tree || "")
    class #{package_class_name} < Kosmos::Package
      title '#{package_title}'
      url '#{package_download_link}'

      def install

      end
    end

    # #{warning}
    # #{forum_url}
  EOS

  puts package_file.yellow

  File.open(File.join('reports', package_file_name), 'w') do |file|
    file.write package_file
  end
end
