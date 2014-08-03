module Kmc
  module Refresher
    class << self
      # Fetch packages from online by git repo.
      def update_packages!
        kmc_packages_path = Kmc::Configuration.packages_path
        output_path = File.absolute_path(File.join(kmc_packages_path, '..'))
        FileUtils::mkdir_p output_path

        GitAdapter.clone(output_path, Kmc.config.packages_url) unless File.exist?(File.join(output_path, '.git'))
        GitAdapter.pull(output_path)
      end
    end
  end
end
