require 'sinatra'

module Kosmos
  module Web
    class App < Sinatra::Application
      get '/' do
        "Hello there! :)"
      end
    end
  end
end
