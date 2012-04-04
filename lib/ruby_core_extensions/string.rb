class String
  def proper_underscore
    self.titleize.gsub(" ","").underscore
  end
  
  # Generate a phonetic code - which is the same for similar sounding names
  def phonetic_code
    # Currently using 'metaphone' which is more accurate than soundex
    Text::Metaphone.metaphone(self)
  end

  def separate_numbers_and_letters(separator = ' ')
    self.gsub(/[a-z][0-9]|[0-9][a-z]/i){ |s| s[0].chr + separator + s[1].chr }
  end

  def to_alphanumeric
    scan(/[a-zA-Z0-9]/).join
  end
  
  def or_default(value)
    if self.empty?
      value
    else
      self
    end
  end

  # convert newlines to breaks
  def nl2br
    gsub(/\n/, '<br />')
  end
  
  # fmt can be either a symbol for the DATE_FORMATS array or an actual format
  # e.g. '%d/%m/%Y'
  # By default it will try to guess the format
  def to_date(fmt = nil)
    if fmt
      fmt = Date::DATE_FORMATS[fmt] if fmt.is_a? Symbol
      date = ::Date.new(*::Date._strptime(self, fmt).values_at(:year, :mon, :mday))
      date = date.change(:year => date.year + 2000) if date.year < 1000 # Warning: Treats 99 as 2099
      date
    else
      if self.match(/\d+\/\d+\/\d+/) # Handle Australian Dates (This should be international/localized)
        to_date('%d/%m/%Y')
      else
        ::Date.new(*::Date._parse(self, false).values_at(:year, :mon, :mday))
      end
    end
  rescue NoMethodError, ArgumentError => e
    raise DateFormatException, "Date #{self} is invalid or not formatted correctly."
  end

  # Squash will reduce words from the end of the string to 3 characters until it
  # fits within the limit or until each words is squashed to 3 characters long
  # e.g.
  # "Adelaide University".squash(10)
  # => "Adelai Uni"
  # "Adelaide University".squash(30)
  # "Adelaide University"
  # "Adelaide University".squash(3)
  # "Ade Uni"
  # "Adelaide University".squash(7)
  # "Ade Uni"
  def squash(limit)
    if size > limit
      words = split(' ')
      if words.size * 1 >= limit
        return words[0..(limit - 1)].map(&:first).join('')
      elsif words.size * 2 > limit
        chop_size = 1
      elsif words.size * 3 > limit
        chop_size = 2
      else
        chop_size = 3
      end
      index = words.size - 1
      cur_size = words.join(' ').size
      while index >= 0 && cur_size > limit
        letters_to_remove = cur_size - limit
        if letters_to_remove >= words[index].size - chop_size
          words[index] = words[index][0..(chop_size - 1)]
        else
          words[index] = words[index][0..(words[index].size-letters_to_remove-1)]
        end

        cur_size = words.join(' ').size
        index -= 1
      end
      final = words.join(' ')
      if final.size > limit
        final[0..(limit - 1)]
      else
        final
      end
    else
      self
    end
  end
  
  
  def to_bool
    return true if self == true || self =~ (/(true|t|yes|y|1)$/i)
    return false if self == false || self.blank? || self =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end

