require 'spec_helper'

describe Array, "When stringiying values recursively" do

  it "should convert integer and time objects in an array to strings" do
    a = [1, 2, Time.now, Time.now+1].stringify_values_recursively
    
    a.each do |v|
      v.class.should == String
    end
  end

  it "should convert all values inside hashes inside an array to strings" do
    a = [{:hey => 243, :ya => Time.now}, 2, {:marble => {:the => 2}, :no => Time.now}].stringify_values_recursively

    a.each do |v|
      check_recursively(v)
    end
  end

  def check_recursively(val)
    if val.is_a?(Hash)
      val.each do |key, value|
        check_recursively(value)
      end
    else
      val.class.should == String
    end
  end

end

describe Array, "When hashing by a key" do

  it "should return a hash with keys created using the chosen method" do
    c = [Time.now, Time.now+15, Time.now+23]
    c_hashed = c.hash_by(:sec)
    
    c_hashed.class.should == Hash
    c_hashed.each_key.with_index do |k, index|
      k.should == c[index].sec
    end
  end

end

describe Array, "When recursively (blank) compacting an array" do

  it "should remove all blank values from the array" do
    a = [1, 0, "Hey", "", Time.now, nil, {}]
    a.recursive_compact_blank!
    a.size.should == 4
  end

  it "should remove blank values in nested arrays/hashed from the array" do
    b = [1, 2, [" Kan", {}], {:ho => "", :heh => {}}, ["garoos", "  "]]
    b.recursive_compact_blank!
    b.join.should == "12 Kangaroos"
  end

end
