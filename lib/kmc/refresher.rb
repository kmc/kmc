module Kmc
  module Refresher
    class << self
      # Fetch packages from online and delete the old packages, if any.
      def update_packages!
        new_packages_dir = File.join(fetch_packages,
          'packages-master', 'packages')

        kmc_packages_path = Kmc::Configuration.packages_path
        output_path = File.join(kmc_packages_path, '..')

        remove_old_packages(kmc_packages_path)
        FileUtils.cp_r(new_packages_dir, output_path)
      end

      private

      def fetch_packages
        zipped_packages = HTTParty.get(Kmc.config.packages_url)
        tmp_zip = PackageDownloads.download_to_tempdir(
          'downloaded_packages.zip', zipped_packages)
        output_path = Pathname.new(tmp_zip.path).parent.to_s

        PackageDownloads.unzip_file(tmp_zip.path, output_path)

        output_path
      end

      def remove_old_packages(kmc_packages_path)
        Dir["#{kmc_packages_path}/*.rb"].each do |file|
          File.delete(file)
        end
      end
    end
  end
end
