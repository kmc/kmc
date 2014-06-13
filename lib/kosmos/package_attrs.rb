module Kosmos
  module PackageAttrs
    def title
      self.class.title
    end

    def url
      self.class.url
    end

    def aliases
      self.class.aliases
    end

    def names
      self.class.names
    end

    private

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def title(title = nil)
        if title
          @title = title
        else
          @title
        end
      end

      def url(url = nil)
        if url
          @url = url
        else
          @url
        end
      end

      def aliases(*aliases)
        @aliases ||= []

        if aliases.any?
          @aliases = aliases
        else
          @aliases
        end
      end

      def names
        [title, aliases].flatten
      end
    end
  end
end
