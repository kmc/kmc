module Kosmos
  class Package
    class << self
      def homepage(homepage)
        @@homepage = homepage
      end

      def url(url)
        @@uri = URI(url)
      end
    end

    def homepage
      @@homepage
    end

    def uri
      @@uri
    end
  end
end
