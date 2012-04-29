class Object
  def convert(&converter)
    converter.call(self)
  end
  
  def return_self
    self
  end
  
  alias_method :convert_values_recursively, :convert
  alias_method :convert_recursively, :convert
  
  alias_method :convert_keys_recursively, :return_self
  alias_method :symbolize_keys_recursively, :return_self
  alias_method :stringify_values_recursively, :return_self
  alias_method :make_indifferent_access_recursively, :return_self
end
