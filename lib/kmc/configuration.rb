module Kosmos
  module Configuration
    class Configurator
      attr_accessor :verbose, :post_processors, :output_method, :packages_url

      def initialize
        @verbose = false
        @post_processors = [Kosmos::PostProcessors::ModuleManagerResolver]
        @output_method = Proc.new { |str| puts str }
        @packages_url = "https://github.com/kmc/packages/archive/master.zip"
      end
    end

    class << self
      def save_ksp_path(path)
        write_config(ksp_path: path)
      end

      def load_ksp_path
        read_config[:ksp_path]
      end

      def cache_dir
        read_config[:cache_dir]
      end

      def packages_path
        File.join(kosmos_path, 'packages', 'packages')
      end

      private

      def write_config(opts)
        ensure_config_exists!

        config_to_write = JSON.pretty_generate(read_config.merge(opts))
        File.open(config_path, "w") do |file|
          file.write config_to_write
        end
      end

      def read_config
        ensure_config_exists!

        config = File.read(config_path)
        if config.empty?
          {}
        else
          JSON.parse(config, symbolize_names: true)
        end
      end

      def ensure_config_exists!
        FileUtils.mkdir_p(kosmos_path)
        FileUtils.touch(config_path)
      end

      def config_path
        File.join(kosmos_path, 'config.json')
      end

      def kosmos_path
        File.join(Dir.home, ".kosmos")
      end
    end
  end
end
