module Kosmos
  module PackageDsl
    def merge_directory(from, opts = {})
      destination = opts[:into] || '.'

      FileUtils.cp_r(File.join(self.class.download_dir, from),
        File.join(self.class.ksp_path, destination))
    end
  end
end
