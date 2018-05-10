class Array
  def to_param
    collect { |element| element.respond_to?(:to_param) ? element.to_param : element }
  end

  def show_name
    first.titleize
  end

  # Key should be unique, or latest element with that key will override previous ones.
  def hash_by(key = nil, method = nil, &block)
    each.with_object({}) do |element, hash|
      if key
        hash[element.send(key)] = if block_given?
                                    yield(element)
                                  elsif method
                                    element.send(method)
                                  else
                                    element
                                  end
      else # key is block and value is element
        hash[yield(element)] = element
      end
    end
  end

  def hash_by_id(method = nil, &block)
    hash_by(:id, method, &block)
  end

  def intersects?(other)
    any? { |i| other.include?(i) }
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
