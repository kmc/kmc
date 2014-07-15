require 'kosmos/configuration'
require 'kosmos/package_dsl'
require 'kosmos/package_attrs'
require 'kosmos/package_downloads'
require 'kosmos/package'
require 'kosmos/versioner'
require 'kosmos/git_adapter'
require 'kosmos/download_url'
require 'kosmos/user_interface'
require 'kosmos/refresher'
require 'kosmos/web/app'
require 'kosmos/util'
require 'kosmos/version'

require 'json'

module Kosmos
  class << self
    def config
      @config ||= Configuration::Configurator.new
    end

    def configure
      yield(config)
    end
  end
end
