class Fixnum
  
  # Returns self as a money (treated as cents)
  def total_money
    zero? ? Money.new(0) : Money.new(self)
  end
  
  def stringify_values_recursively
    self.to_s
  end
  
end

