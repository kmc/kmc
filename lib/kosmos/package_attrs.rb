module Kosmos
  module PackageAttrs
    %i(title url aliases names prerequisites postrequisites).each do |property|
      define_method(property) do
        self.class.send(property)
      end
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
