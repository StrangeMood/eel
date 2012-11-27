class Symbol

  delegate :gt, :desc, :asc, to: :attr

  def attr
    attr = Arel::Attributes::Attribute.new
    attr.name = self
    attr
  end

end