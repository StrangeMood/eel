module Eel
  module CoreExt
    module SymbolExtensions

      def attr
        Arel::Attributes::Attribute.new(nil, self)
      end

      def of val
        relation = case val
                     when Class
                       val.arel_table
                     when Symbol
                       val
                     when String
                       Arel::Table.new(val)
                     else
                       raise "Can't use #{val.class} as a relation"
                   end

        Arel::Attributes::Attribute.new(relation, self)
      end

      def respond_to_missing? method_name, private = false
        method_name.in? predicates
      end

      def method_missing method_name, *args, &block
        if method_name.in? predicates
          if args.present?
            attr.send(method_name, *args) # binary nodes
          else
            attr.send(method_name)        # unary nodes
          end
        else
          super
        end
      end

      private

      def predicates
        Arel::OrderPredications.instance_methods + Arel::Predications.instance_methods
      end

    end
  end
end