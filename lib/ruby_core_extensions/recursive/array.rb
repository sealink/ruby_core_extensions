 class Array 
  def convert
    self
  end

  def convert_keys_recursively(&converter)
    map { |v| v.convert_keys_recursively(&converter) }
  end
  
  def convert_values_recursively(&converter)
    map { |v| v.convert_values_recursively(&converter) }
  end
  
  def symbolize_keys_recursively
    map(&:symbolize_keys_recursively)
  end
  
  def stringify_values_recursively
    map(&:stringify_values_recursively)
  end
  
  def make_indifferent_access_recursively
    map(&:make_indifferent_access_recursively)
  end
  
  def recursive_blank?
    each do |v|
      if v.respond_to?(:recursive_blank?)
        return false unless v.recursive_blank?
      else
        return false unless v.blank?
      end
    end
    true
  end
end
