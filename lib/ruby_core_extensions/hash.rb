class Hash
  
  unless self.method_defined?(:extract!)
    #Imported from Rails 3
    def extract!(*keys)
      result = {}
      keys.each { |key| result[key] = delete(key) }
      result
    end
  end
  
end
