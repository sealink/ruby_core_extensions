require 'spec_helper'


describe Array do
  
  it "should allow converting to a hash" do
    [[:a,1],[:b,2]].to_hash.should == {:a => 1, :b => 2}
  end
  
  it "should allow converting all values to strings recursively" do
    [1, 2, Time.now, [3, 4]].stringify_values_recursively.should eql ['1', '2', Time.now.to_s, ['3', '4']]
  end
  
  it "should allow removing all blank values" do
    a = [1, nil, 3, '']
    a.compact_blank!
    a.should == [1, 3]
  end
  
  it "should allow removing all blank values recursively" do
    a = [1, 2, [" Kan", {}], nil, {:a => "", :b => {}}, ["garoos", "  "]]
    a.recursive_compact_blank!
    a.join.should == "12 Kangaroos"
  end
  
end