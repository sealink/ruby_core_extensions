require 'spec_helper'

describe Time do
  
  before do
    @time = Time.parse("2010-01-01 09:30:00")
  end
  
  it "should allow setting the date part given a date" do
    @time.set_date(Date.parse("2012-12-31")).should eql Time.parse("2012-12-31 09:30:00")
  end
  
end