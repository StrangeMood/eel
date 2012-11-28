module Eel
  module CoreExt
    module SymbolExtensions

      def between *other
        other = other.flatten
        Arel::Nodes::Between.new(attr, Arel::Nodes::And.new(other))
      end

      def attr
        attr = Arel::Attributes::Attribute.new
        attr.name = self
        attr
      end

      def of val
        relation = case val
                     when Class
                       val.arel_table
                     when Symbol
                       val
                     when String
                       val.classify.constantize
                     else
                       raise "Can't use #{val.class} as a relation"
                   end

        attr = Arel::Attributes::Attribute.new
        attr.name = self
        attr.relation = relation
        attr
      end

      def respond_to_missing? method_name, private = false
        Arel::Attributes::Attribute.new.respond_to?(method_name)
      end

      def method_missing method_name, *args, &block
        if Arel::Attributes::Attribute.new.respond_to?(method_name)
          SymbolExtensions.class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
            def #{method_name} *args
              attr.#{method_name}(*args)
            end
          RUBY

          self.send(method_name, *args)
        else
          super
        end
      end

    end
  end
end