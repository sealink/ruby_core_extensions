class Object
  def convert(&converter)
    converter.call(self)
  end

  def return_self
    self
  end

  alias convert_values_recursively convert
  alias convert_recursively convert

  alias convert_keys_recursively return_self
  alias symbolize_keys_recursively return_self
  alias stringify_values_recursively return_self
  alias make_indifferent_access_recursively return_self
end
