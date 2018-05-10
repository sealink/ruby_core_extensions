class Object
  # Does this object sound like another - phonetically?
  def sounds_like?(other)
    phonetic_code == other.phonetic_code
  end

  # Convert this object into a string, then convert that to phonetic code
  def phonetic_code
    to_s.phonetic_code
  end

  def to_long_s
    to_s
  end

  def virtual_belongs_to(*associations)
    options = associations.extract_options!

    associations.each do |association|
      class_eval <<-EVAL
        attr_accessor :#{association}, :#{association}_id

        def #{association}=(#{association})
          @#{association}_id = #{association}.id if #{association}
          @#{association} = #{association}
        end

        def #{association}_id=(#{association}_id)
          @#{association} = nil
          @#{association}_id = #{association}_id
        end

        def #{association}
          @#{association} ||= #{(options[:class_name] || association.to_s).classify}.find_by_id(@#{association}_id)
        end

        def #{association}_id
          @#{association}.id if #{association}
        end
      EVAL
    end
  end

  def booleanize(name, options)
    raise ArgumentError, ':rescue option is required' if options[:rescue].blank?
    options[:rescue] = [options[:rescue]] unless options[:rescue].is_a?(Array)

    normal_name = name.to_s.gsub('!', '')

    class_eval <<-EVAL
      attr_accessor :reason_not_#{normal_name}
      def #{normal_name}?(*args)
        #{name}(*args)
        @reason_not_#{normal_name} = nil
        true
      rescue #{options[:rescue].map(&:to_s).join(', ')} => e
        @reason_not_#{normal_name} = e.message
        false
      end
    EVAL
  end

  def to_bool
    to_s.to_bool
  end
end
