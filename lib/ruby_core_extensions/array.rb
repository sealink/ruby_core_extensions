class Array
  # Returns sum as a money - and returns 0 for empty arrays 
  def total_money
    blank? ? Money.new(0) : sum
  end
  
  def to_param
    self.collect { |element| element.respond_to?(:to_param) ? element.to_param : element }
  end 

  def show_name
    first.titleize
  end  

  def to_model(klass)
    if self.blank?
      self
    else
      klass.find_all_by_id(self)
    end
  end
  
  def to_hash
    inject({}) { |m, e| m[e[0]] = e[1]; m }
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

  # Key should be unique, or latest element with that key will override previous ones.
  def hash_by(key, method = nil, &block)
    self.inject({}) do |h, element|
      h[element.send(key)] = if block_given?
        yield(element)
      elsif method
        element.send(method)
      else
        element
      end
      h
    end
  end

  def hash_by_id(method = nil, &block)
    hash_by(:id, method, &block)
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
  
end

