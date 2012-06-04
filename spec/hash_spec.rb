require 'spec_helper'

describe Hash do

  before do
    @hash1 = {:a  => 1, :b  => {:c  => 2}, :d => 'test', :e  => [3, 4, {:f  => 5}]}
    @hash2 = {'a' => 1, 'b' => {'c' => 2}, :d => 'test', 'e' => [3, 4, {'f' => 5}]}
  end

  it "should allow converting all values to strings recursively" do
    @hash1.stringify_values_recursively.should == {:a => "1", :b => {:c => "2"}, :d => "test", :e => ["3", "4", {:f => "5"}]}
  end

  it "should allow converting all keys to symbols recursively" do
    @hash2.symbolize_keys_recursively.should == @hash1
  end

  it "should allow converting keys" do
    @hash1.convert_keys(&:to_s).should == {"a" => 1, "b" => {:c => 2}, "d" => "test", "e" => [3, 4, {:f => 5}]}
  end

  it "should allow converting values" do
    @hash1.convert_values(&:to_s).should == {:a => "1", :b => {:c => 2}, :d => "test", :e => [3, 4, {:f => 5}]}
  end
  
  it "should allow converting values only for specific keys" do
    @hash1.convert_values(:d, :e, &:to_s).should == {:a => 1, :b => {:c => 2}, :d => "test", :e => [3, 4, {:f => 5}]}
  end

  it "should allow making indifferent access recursively" do
    @hash1.make_indifferent_access_recursively['b']['c'].should eql 2
    @hash1.make_indifferent_access_recursively['e'][2]['f'].should eql 5
  end

end


describe Hash do

  it 'should allow removing all nil values and return a new hash' do
    {:a => 1, :b => nil}.compact.should == {:a => 1}
  end

  it 'should allow removing all nil values' do
    a = {:a => 1, :b => nil}
    a.compact!
    a.should == {:a => 1}
  end

  it 'should allow removing all nil values and return a new hash' do
    {:a => 1, :b => ''}.compact_blank.should == {:a => 1}
  end

  it 'should allow removing all blank values' do
    a = {:a => 1, :b => ''}
    a.compact_blank!
    a.should == {:a => 1}
  end

  it 'should allow removing all blank values recursively' do
    a = {:a => 1, :b => {:c => 1, :d => '', :e => []}}
    a.recursive_compact_blank!
    a.should == {:a => 1, :b => {:c => 1}}
  end

end
