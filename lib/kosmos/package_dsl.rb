module Kosmos
  module PackageDsl
    def merge_directory(from, opts = {})
      destination = opts[:into] || '.'

      FileUtils.cp_r(File.join(@download_dir, from),
        File.join(@ksp_path, destination))
    end
    
    def remove(path, opts = {})
      FileUtils.rm_rf(File.join(@ksp_path, path))
    end
  end
end
