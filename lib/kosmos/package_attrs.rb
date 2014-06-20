module Kosmos
  module PackageAttrs
    private

    def self.included(base)
      base.extend(Methods)
      base.send(:include, Methods)
    end

    module Methods
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

      def resolve_prerequisites
        prerequisites.map { |package_name| find(package_name) }
      end

      def resolve_postrequisites
        postrequisites.map { |package_name| find(package_name) }
      end

    end
  end
end
