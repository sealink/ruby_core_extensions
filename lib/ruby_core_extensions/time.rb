class Time
  
  def set_date(date)
    self.change(:year => date.year, :month => date.month, :day => date.day)
  end
  
  def stringify_values_recursively
    self.to_s
  end
  
end

module ActiveSupport
  class TimeWithZone
    def seconds_since
      (Time.now - self).to_i
    end

    def minutes_since
      seconds_since/60
    end

    def hours_since
      minutes_since/60
    end
  end
end
