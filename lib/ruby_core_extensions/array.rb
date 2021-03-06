class Array
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

  def intersects?(other)
    self.any? { |i| other.include?(i) }
  end

  # Same effect as Array.wrap(object).first
  # but no need to create new object in case of non-array
  def self.first(object)
    return object.first if object.is_a?(Array)
    object
  end

  # Same effect as Array.wrap(object).last
  # but no need to create new object in case of non-array
  def self.last(object)
    return object.last if object.is_a?(Array)
    object
  end
end
