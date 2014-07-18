require 'bundler/setup'
Bundler.setup

require 'kmc'

require 'webmock/rspec'
require 'fileutils'
require 'ostruct'
require 'fakefs/safe'
require 'pry'

module FakeFS
  class File
    def self.absolute_path(file_name, dir_name = Dir.getwd)
      RealFile.absolute_path(file_name, dir_name)
    end
  end

  class Dir
    def self.home
      ""
    end
  end
end

RSpec.configure do |config|
  config.color_enabled = true
end
