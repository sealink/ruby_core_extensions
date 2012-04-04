class Range
  # Returns true if ranges overlap, false otherwise
  # - copied from Rails 2.0
  def overlaps?(other)
    include?(other.first) || other.include?(first)
  end

  def to_date_range
    DateRange.new(self.first, self.last)
  end

  def days_from_current
    (Date.current + self.first)..(Date.current + self.last)
  end
end

