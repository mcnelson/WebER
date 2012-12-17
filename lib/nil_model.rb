class NilModel
  def to_a; []; end
  def to_s; ""; end
  def to_f; 0.0; end
  def to_i; 0; end

  def nil?
    true
  end

  def blank?
    true
  end

  def method_missing(method_id, *args, &block)
    return super unless UpcMaster.attribute_method? method_id

    case Unit.columns(&:type).select { |c| c.name == method_id.to_s } .first.try(:type)
      when :decimal
        0.0
      when :string, :text
        ""
      when :integer
        0
      when :datetime
        Date.new(2000, 1, 1)
      when :boolean
        false
    end
  end
end
