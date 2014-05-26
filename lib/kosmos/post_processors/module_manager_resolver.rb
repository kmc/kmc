module Kosmos
  module PostProcessors
    class ModuleManagerResolver
      def self.post_process(ksp_path)
        game_data = File.join(ksp_path, 'GameData')

        module_managers = Dir[File.join(game_data, '*')].select do |file|
          File.basename(file).start_with?('ModuleManager')
        end

        most_recent_manager = module_managers.max_by do |file|
          # Rather than do some fancy parsing, we'll just find the module
          # version number by removing any non-numerical symbols from the
          # basename, and assume the rest is a version number.
          #
          # Then, we just sort by those numbers.
          #
          # This technique will fail if a) the file name is weird, or b) the
          # version number goes up to 10, because sorting is done
          # alphabetically.
          File.basename(file).gsub(/[^\d]/, '')
        end

        (module_managers - [most_recent_manager]).each do |file|
          Util.log "Detected and deleting outdated version of ModuleManager: #{file}"

          File.delete(file)
        end
      end
    end
  end
end
