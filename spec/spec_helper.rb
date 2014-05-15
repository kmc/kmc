require 'bundler/setup'
Bundler.setup

require 'kosmos'

require 'webmock/rspec'
require 'fileutils'

RSpec.configure do |config|
  config.color_enabled = true
end
