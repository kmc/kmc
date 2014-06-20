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

    def prerequisites
      self.class.prerequisites
    end

    def postrequisites
      self.class.postrequisites
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

      def prerequisites(*prerequisites)
        @prerequisites ||= []

        if prerequisites.any?
          @prerequisites = prerequisites
        else
          @prerequisites
        end
      end

      def postrequisites(*postrequisites)
        @postrequisites ||= []

        if postrequisites.any?
          @postrequisites = postrequisites
        else
          @postrequisites
        end
      end
    end
  end
end
