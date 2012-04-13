class Date
  
  def to_time_in_time_zone
    (Time.zone || ActiveSupport::TimeZone["UTC"]).local(self.year, self.month, self.day)
  end
  
  
  def stringify_values_recursively
    self.to_s
  end
  
end

