module Enumerable

  def map_methods(*methods)
    map do |object|
      methods.inject({}) do |h, method|
        h[method] = object.send(method)
        h
      end
    end
  end


  if RUBY_VERSION < '1.9'
    def with_object(obj, &block)
      return to_enum :with_object, obj unless block_given?
      each do |element|
        yield element, obj
      end
      obj
    end
  end

end

