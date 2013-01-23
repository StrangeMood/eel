module Eel
  module ActiveRecord
    module QueryExtensions

      def order *args
        return self if args.blank?
        super *args.flatten.map { |a| assign_context(a); a }
      end

      def reorder *args
        return self if args.blank?
        super *args.flatten.map { |a| assign_context(a); a }
      end

      def build_where(opts, other = [])
        case opts
          when Arel::Nodes::Node
            nodes = [opts] + other
            nodes.each do |node|
              assign_context(node)
            end
            nodes
          else
            super
        end
      end

      private

      def assign_context input
        case input
          when Arel::Nodes::Unary
            assign_context(input.expr)
          when Arel::Nodes::Binary
            assign_context(input.left)
            assign_context(input.right)
          when Arel::Nodes::And
            input.children.each {|ch| assign_context(ch)}
          when Arel::Attributes::Attribute
            case input.relation
              when Symbol
                input.relation = Arel::Table.new(input.relation, table.engine)
              when NilClass
                input.relation = table
            end
          else
            # do nothing
        end
        input
      end

    end
  end
end