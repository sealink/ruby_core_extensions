require "active_support/hash_with_indifferent_access"

class Hash
  
  def all_empty_values?
    self.values.delete_if { |v| v.blank? }.empty? 
  end
  
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
    inject({}) do |hash, (key, value)|
      hash[converter.call(key)] = value
      hash
    end
  end
  
  def convert_values(&converter)
    inject({}) do |hash, (key, value)|
      hash[key] = value.convert(&converter)
      hash
    end
  end

  def convert_keys_recursively(&converter)
    Hash[map do |key, value|
          k = converter.call(key)
          v = value.convert_keys_recursively(&converter)
          [k,v]
        end]
  end
  
  def convert_values_recursively(&converter)
    inject({}) do |hash, (key, value)|
      hash[key] = value.convert_values_recursively(&converter)
      hash
    end
  end
  
  def symbolize_keys_recursively
    Hash[map do |key, value|
          k = key.is_a?(String) ? key.to_sym : key
          v = value.symbolize_keys_recursively
          [k,v]
        end]
  end
  
  def stringify_values_recursively
    inject({}) do |options, (key, value)|
      options[key] = value.stringify_values_recursively
      options
    end
  end
  
  def make_indifferent_access_recursively
    HashWithIndifferentAccess.new(inject({}) do |options, (key, value)|
        options[key] = value.make_indifferent_access_recursively
        options
      end)
  end
  
  def deep_dup
    duplicate = self.dup
    duplicate.each_pair do |k,v|
      tv = duplicate[k]
      duplicate[k] = tv.is_a?(Hash) && v.is_a?(Hash) ? tv.deep_dup : v
    end
    duplicate
  end
  
end

