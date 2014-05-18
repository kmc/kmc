require 'kosmos/package_dsl'
require 'kosmos/package'
require 'kosmos/versioner'
require 'kosmos/git_adapter'
require 'kosmos/version'

module Kosmos
  class InvalidUninstallError < StandardError
  end

  def self.save_ksp_path(path)
    File.open(config_path, "w+") do |file|
      file.write(path)
    end
  end

  def self.load_ksp_path
    File.read(config_path)
  end

  private

  def self.config_path
    File.join(Dir.home, ".kosmos")
  end
end
