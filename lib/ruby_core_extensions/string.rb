class String
  def proper_underscore
    self.titleize.gsub(" ","").underscore
  end
  
  # Generate a phonetic code - which is the same for similar sounding names
  def phonetic_code
    # Currently using 'metaphone' which is more accurate than soundex
    Text::Metaphone.metaphone(self)
  end

  # Solr requires numbers and letters to be separated
  def separate_numbers_and_letters
    gsub(/[a-z][0-9]|[0-9][a-z]/i){ |s| s[0].chr + ' ' + s[1].chr }
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
  # fits within the limit, shrinking all words evenly.
  # Where not all words can be shrunk evenly, the last words will be reduced by 1
  # Until within the limit
  # e.g.
  # "Adelaide University".squash(30)
  # => "Adelaide University"
  # "Adelaide University".squash(10)
  # => "Adela Univ"
  # "Adelaide University".squash(7)
  # => "Ade Uni"
  # "Adelaide University".squash(3)
  # => "AU"
  # "Adelaide University".squash(2)
  # => "AU"
  # "Adelaide University".squash(1)
  # => "A"
  def squash(limit)
    return self if size <= limit

    words = split(' ')

    # Return first letter of <limit> words
    return words.first(limit).map{|w| w.chars.first}.join if (words.size * 2 - 1) >= limit

    spaces = words.size - 1
    word_char_min = (limit - spaces) / words.size
    word_char_max = word_char_min + 1

    words = words.map{|word| word[0..(word_char_max - 1)]}

    words.reverse.each.with_index do |word, index|
      letters_to_remove = words.join(' ').size - limit

      letters_to_keep = if (last_case = (letters_to_remove <= (word.size - word_char_min)))
        word.size - letters_to_remove # Removing final characters
      else
        word_char_min
      end

      # Replace word
      words[words.size -  index - 1] = word[0..(letters_to_keep - 1)]

      break if last_case
    end

    words.join(' ')
  end
  
  
  def to_bool
    return true if self == true || self =~ (/(true|t|yes|y|1)$/i)
    return false if self == false || self.blank? || self =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end

