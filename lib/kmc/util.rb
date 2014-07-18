module Kmc
  module Util
    def self.log(msg)
      Kmc.config.output_method.call(msg) if Kmc.config.verbose
    end

    def self.run_post_processors!(ksp_path)
      Kmc.config.post_processors.each { |p| p.post_process(ksp_path) }
    end
  end
end
