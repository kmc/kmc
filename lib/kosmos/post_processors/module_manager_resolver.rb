module Kosmos
  module PostProcessors
    class ModuleManagerResolver
      def self.post_process(ksp_path)
        module_managers = Dir.chdir(ksp_path) do
          Dir["GameData/*"].select do |file|
            File.basename(file).start_with?('ModuleManager')
          end
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
          file_name = File.basename(file)
          Util.log "Detected and deleting outdated version of ModuleManager: " +
              "#{file_name}"

          File.delete(File.join(ksp_path, file))
        end
      end
    end
  end
end
