require 'sinatra'

module Kmc
  module Web
    class App < Sinatra::Application
      set server: 'thin', connection: nil

      get '/' do
        send_file(File.join(settings.public_folder, 'index.html'))
      end

      get '/stream', provides: 'text/event-stream' do
        stream :keep_open do |out|
          settings.connection = out
        end
      end

      post '/' do
        Kmc.configure do |config|
          config.output_method = Proc.new do |str|
            # Send to STDOUT
            puts str

            # And to the in-browser UI
            str.split("\n").each do |line|
              settings.connection << "data: #{line}\n\n"
            end
          end
        end

        kmc_params = params[:params].split(' ')
        kmc_command = %w(init install uninstall list).find do |command|
          command == params[:command]
        end

        UserInterface.send(kmc_command, kmc_params)

        204
      end
    end
  end
end
