module Kosmos
  module PostProcessors
    class ModuleManagerResolver
      def self.post_process(ksp_path)
        game_data = File.join(ksp_path, 'GameData')

        module_managers = Dir[File.join(game_data, '*')].select do |file|
          File.basename(file).start_with?('ModuleManager')
        end

        most_recent_manager = module_managers.max_by do |file|
          # Converts a string like this:
          #
          #   ModuleManager.5.2.3
          #
          # Into this:
          #
          #   [5, 2, 3]
          File.basename(file).scan(/\d+/).map(&:to_i)
        end

        (module_managers - [most_recent_manager]).each do |file|
          Util.log "Detected and deleting outdated version of ModuleManager: #{file}"

          File.delete(file)
        end
      end
    end
  end
end
