module Enumerable
  
  def map_methods(*methods)
    map do |object|
      methods.inject({}) do |h, method|
        h[method] = object.send(method)
        h
      end
    end
  end
  
end

