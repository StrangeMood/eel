module Eel
  module ActiveRecord
    module QueryExtensions

      def order *args
        return self if args.blank?

        super *args.flatten.map { |a| assign_context(a) }
      end

      def build_where(opts, other = [])
        case opts
          when Arel::Nodes::Node
            nodes = [opts] + other
            nodes.each do |node|
              assign_context(node.left)
              assign_context(node.right)
            end
            nodes
          else
            super
        end
      end

      private

      def assign_context attr
        if attr.is_a?(Arel::Attributes::Attribute) && attr.relation.blank?
          attr.relation = table
        end
        attr
      end

    end
  end
end