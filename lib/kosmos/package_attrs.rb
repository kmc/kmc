module Kosmos
  module PackageAttrs
    private

    def self.included(base)
      base.extend(Methods)

      Methods.public_instance_methods.each do |method_name|
        base.send(:define_method, method_name, Proc.new do |*args|
          self.class.send(method_name, *args)
        end)
      end
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

      alias_method :prerequiste, :prerequisites
      alias_method :pre_requisite, :prerequisites
      alias_method :pre_requisites, :prerequisites

      def postrequisites(*postrequisites)
        @postrequisites ||= []

        if postrequisites.any?
          @postrequisites = postrequisites
        else
          @postrequisites
        end
      end

      alias_method :postrequiste, :postrequisites
      alias_method :post_requisite, :postrequisites
      alias_method :post_requisites, :postrequisites

      def resolve_prerequisites
        prerequisites.map { |package_name| find(package_name) }
      end

      def resolve_postrequisites
        postrequisites.map { |package_name| find(package_name) }
      end

    end
  end
end
