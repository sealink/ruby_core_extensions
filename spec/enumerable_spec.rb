require 'spec_helper'

describe Enumerable do
  
  it 'should allow mapping elements of the collection to hashes associating method names to the returned values for each method' do
    [1,2,3].map_methods(:to_s,:to_f).should eql [{:to_s => '1', :to_f => 1.0}, {:to_s => '2', :to_f => 2.0}, {:to_s => '3', :to_f => 3.0}]
  end


  context 'when detecting and returning the block value' do
    it { [1,2,3].detect_and_return { |number| number.even? && number * number }.should == 4 }
    it { [1,3,5].detect_and_return { |number| number.even? && number * number }.should be nil }
  end


  it 'should allow selecting by attribute' do
    one = double(:name => 'one', :type => 'odd')
    two = double(:name => 'two', :type => 'even')
    thr = double(:name => 'thr', :type => 'odd')
    [one, two, thr].select_by_attr(:type, 'odd').should == [one, thr]
    [one, two, thr].select_by_attr(:type, 'even').should == [two]
  end
  
end
