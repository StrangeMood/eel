module Eel
  module ActiveRecord
    module QueryExtensions

      def order *args
        return self if args.blank?
        super *args.flatten.map { |a| assign_context(a.expr) if a.respond_to?(:expr); a }
      end

      def reorder *args
        return self if args.blank?
        super *args.flatten.map { |a| assign_context(a.expr) if a.respond_to?(:expr); a }
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
        if attr.is_a?(Arel::Attributes::Attribute)
          case attr.relation
            when Symbol
              attr.relation = Arel::Table.new(attr.relation, table.engine)
            when NilClass
              attr.relation = table
          end
        end
        attr
      end

    end
  end
end