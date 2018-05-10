class Hash
  def recursive_blank?
    each do |k, v|
      if v.respond_to?(:recursive_blank?)
        return false unless v.recursive_blank?
      else
        return false unless v.blank?
      end
    end
    true
  end

  def convert
    self
  end

  def convert_keys(&converter)
    each.with_object({}) do |(key, value), hash|
      hash[converter.call(key)] = value
    end
  end

  def convert_values(*keys, &converter)
    each.with_object(clone) do |(key, value), hash|
      hash[key] = value.convert(&converter) if keys.blank? || keys.include?(key)
    end
  end

  def convert_keys_recursively(&converter)
    map.with_object({}) do |(key, value), hash|
      k = converter.call(key)
      hash[k] = value.convert_keys_recursively(&converter)
    end
  end

  def convert_values_recursively(&converter)
    each.with_object({}) do |(key, value), hash|
      hash[key] = value.convert_values_recursively(&converter)
    end
  end

  def symbolize_keys_recursively
    map.with_object({}) do |(key, value), hash|
      k = key.is_a?(String) ? key.to_sym : key
      hash[k] = value.symbolize_keys_recursively
    end
  end

  def stringify_values_recursively
    each.with_object({}) do |(key, value), hash|
      hash[key] = value.stringify_values_recursively
    end
  end

  def make_indifferent_access_recursively
    HashWithIndifferentAccess.new(
      each.with_object({}) do |(key, value), hash|
        hash[key] = value.make_indifferent_access_recursively
      end
    )
  end

  def deep_dup
    duplicate = dup
    duplicate.each_pair do |k, v|
      tv = duplicate[k]
      duplicate[k] = tv.is_a?(Hash) && v.is_a?(Hash) ? tv.deep_dup : v
    end
    duplicate
  end

  def recursively(&block)
    each do |key, value|
      block.call(key, value)
      value.recursively(&block) if value.respond_to?(:recursively)
    end
  end
end
