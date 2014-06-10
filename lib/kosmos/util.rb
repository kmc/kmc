module Kosmos
  module Util
    def self.log(msg)
      puts msg if Kosmos.config.verbose
    end

    def self.run_post_processors!(ksp_path)
      Kosmos.config.post_processors.each { |p| p.post_process(ksp_path) }
    end
  end
end
