module Eel
  module CoreExt
    module SymbolExtensions

      def between *other
        other = other.flatten
        Arel::Nodes::Between.new(attr, Arel::Nodes::And.new(other))
      end

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
                       val.to_sym
                     else
                       raise "Can't use #{val.class} as a relation"
                   end

        Arel::Attributes::Attribute.new(relation, self)
      end

      def respond_to_missing? method_name, private = false
        Arel::Attributes::Attribute.new.respond_to?(method_name)
      end

      def method_missing method_name, *args, &block
        if Arel::Attributes::Attribute.new.respond_to?(method_name)
          SymbolExtensions.class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
            delegate :#{method_name}, to: :attr
          RUBY

          if args.present?
            attr.send(method_name, *args) # binary nodes
          else
            attr.send(method_name)        # unary nodes
          end
        else
          super
        end
      end

    end
  end
end