module Arel
  module Predications
    def between(*other)
      range = Nodes::And.new(other.flatten)
      Nodes::Between.new self, range
    end

    def is_null
      Nodes::Equality.new(self, nil)
    end

    def is_not_null
      Nodes::NotEqual.new(self, nil)
    end
  end
end