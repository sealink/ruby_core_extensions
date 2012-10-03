class Array
  
  def to_param
    self.collect { |element| element.respond_to?(:to_param) ? element.to_param : element }
  end 

  def show_name
    first.titleize
  end  

  def id_to_model(klass)
    if self.blank?
      self
    else
      klass.find_all_by_id(self)
    end
  end
  
  #def to_hash
  #  inject({}) { |m, e| m[e[0]] = e[1]; m }
  #end

  # Key should be unique, or latest element with that key will override previous ones.
  def hash_by(key = nil, method = nil, &block)
    self.inject({}) do |h, element|
      if key
        h[element.send(key)] = if block_given?
          yield(element)
        elsif method
          element.send(method)
        else
          element
        end
      else # key is block and value is element
        h[yield(element)] = element
      end
      h
    end
  end

  def hash_by_id(method = nil, &block)
    hash_by(:id, method, &block)
  end
  
end

