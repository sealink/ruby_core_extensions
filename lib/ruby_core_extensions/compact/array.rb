class Array
  def compact_blank!
    delete_if{|v| v.blank?}
  end

  def recursive_compact_blank!
    delete_if do |v|
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

