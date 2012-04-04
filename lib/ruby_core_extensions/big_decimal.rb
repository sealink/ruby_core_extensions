class BigDecimal
  
  def negative?
    self < BigDecimal.new('0')
  end

  def positive?
    self > BigDecimal.new('0')
  end
  
  def stringify_values_recursively
    self.to_s
  end
  
end

