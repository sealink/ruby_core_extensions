class Hash
  # Remove nil values
  def compact
    self.dup.compact!
  end

  # Remove nil values - !desctructively!
  def compact!
    delete_if{|k,v| v.nil?}
  end

  def compact_blank
    self.dup.compact_blank!
  end

  def compact_blank!
    delete_if{|k,v| v.blank?}
  end

  def recursive_compact_blank!
    delete_if do |k,v|
      if v.is_a?(Hash)
        v.recursive_compact_blank!
        v.recursive_blank?
      elsif v.is_a?(Array)
        v.recursive_compact_blank!
        v.recursive_blank?
      else
        v.blank?
      end
    end
  end
end

