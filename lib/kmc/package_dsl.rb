module Kmc
  module PackageDsl
    def merge_directory(from, opts = {})
      destination = opts[:into] || '.'

      FileUtils.mkdir_p(File.dirname(File.join(self.class.ksp_path, filepath)))
      FileUtils.cp_r(File.join(self.class.download_dir, from),
        File.join(self.class.ksp_path, destination))
    end
    def remove_filepath(filepath)
      FileUtils.rm_r(File.join(self.class.ksp_path, filepath))
    end
  end
end
