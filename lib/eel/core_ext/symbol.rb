class Symbol

  delegate :gt, :gteq, :lt, :lteq,
           :eq, :not_eq, :in, :not_in,
           :desc, :asc,
           to: :attr

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

end