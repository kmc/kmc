module Kosmos
  module Util
    def self.log(msg)
      puts msg if Kosmos.config.verbose
    end
  end
end
