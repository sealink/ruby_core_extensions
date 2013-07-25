module Enumerable

  def map_methods(*methods)
    map do |object|
      methods.inject({}) do |h, method|
        h[method] = object.send(method)
        h
      end
    end
  end


  def detect_and_return
    detect do |e|
      result = yield(e)
      return result if result
    end
  end


  def select_by_attr(attr, value)
    select do |e|
      e.send(attr) == value
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

