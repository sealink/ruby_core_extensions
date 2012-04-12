require 'spec_helper'

describe Enumerable do
  
  it "should allow mapping elements of the collection to hashes associating method names to the returned values for each method" do
    [1,2,3].map_methods(:to_s,:to_f).should eql [{:to_s => "1", :to_f => 1.0}, {:to_s => "2", :to_f => 2.0}, {:to_s => "3", :to_f => 3.0}]
  end
  
end