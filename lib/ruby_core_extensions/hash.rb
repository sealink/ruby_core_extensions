class Hash
  def map_key_value(key_method, value_method = nil)
    value_method ||= key_method
    each.with_object({}) do |(k, v), new_hash|
      new_hash[k.send(key_method)] = v.send(value_method)
    end
  end


  def map_key(method)
    each.with_object({}) do |(k, v), new_hash|
      new_hash[k.send(method)] = v
    end
  end


  def map_value(method)
    each.with_object({}) do |(k, v), new_hash|
      new_hash[k] = v.send(method)
    end
  end
end
