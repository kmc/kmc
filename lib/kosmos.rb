require 'kosmos/package_dsl'
require 'kosmos/package'
require 'kosmos/versioner'
require 'kosmos/git_adapter'
require 'kosmos/download_url'
require 'kosmos/util'
require 'kosmos/version'

module Kosmos
  class InvalidUninstallError < StandardError
  end

  class << self
    def config
      @config ||= Configuration.new
    end

    def configure
      yield(config)
    end

    def save_ksp_path(path)
      File.open(config_path, "w+") do |file|
        file.write(path)
      end
    end

    def load_ksp_path
      File.read(config_path)
    end

    private

    def config_path
      File.join(Dir.home, ".kosmos")
    end
  end

  class Configuration
    attr_accessor :verbose, :post_processors

    def initialize
      @verbose = false
      @post_processors = [Kosmos::PostProcessors::ModuleManagerResolver]
    end
  end
end
