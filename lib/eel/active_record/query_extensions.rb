module Eel
  module ActiveRecord
    module Eel::QueryExtensions

      def order *args
        return self if args.blank?

        normalized_args = args.flatten.map do |a|
          if Arel::Nodes::Unary === a
            a.expr.relation = table if Arel::Attributes::Attribute === a.expr
          end
          a
        end
        super(*normalized_args)
      end

      def build_where(opts, other = [])
        case opts
          when Arel::Nodes::Node
            nodes = [opts] + other
            assign_context(nodes)
            nodes
          else
            super
        end
      end

      private

      def assign_context attribute
        if attribute.is_a?(Arel::Attributes::Attribute) && attribute.relation.blank?
          attribute.relation = table
        end
      end

    end
  end
end