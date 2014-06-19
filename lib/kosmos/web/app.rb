require 'sinatra'

module Kosmos
  module Web
    class App < Sinatra::Application
      get '/' do
        send_file(File.join(settings.public_folder, 'index.html'))
      end
    end
  end
end
