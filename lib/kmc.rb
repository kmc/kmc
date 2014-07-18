require 'kmc/configuration'
require 'kmc/package_dsl'
require 'kmc/package_attrs'
require 'kmc/package_downloads'
require 'kmc/package'
require 'kmc/versioner'
require 'kmc/git_adapter'
require 'kmc/download_url'
require 'kmc/user_interface'
require 'kmc/refresher'
require 'kmc/web/app'
require 'kmc/util'
require 'kmc/version'

require 'json'

module Kmc
  class << self
    def config
      @config ||= Configuration::Configurator.new
    end

    def configure
      yield(config)
    end
  end
end
