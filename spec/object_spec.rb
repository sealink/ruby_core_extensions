require 'spec_helper'

describe Object do

  class TestClass; end

  class TestModel
    def id; 1; end
  end
  
  before do
    @object = TestClass.new
  end
  
  it "should allow definig virtual belongs_to associations" do
    lambda { @object.virtual_belongs_to(:test_model) }.should_not raise_error
    lambda { @object.test_model = TestModel.new }.should_not raise_error
    @object.test_model_id.should eql 1
  end
  
end


describe Object do
  
  class ReadyException < Exception; end

  class BooleanizeTest
    
    attr_accessor :ready
    
    def verify!
      raise "Ready should be a boolean" unless ready.is_a?(TrueClass) || ready.is_a?(FalseClass)
      raise ReadyException, "Not ready" unless ready
    end
    
  end
  
  
  before do
    @object = BooleanizeTest.new
  end
  
  
  it "should allow defining methods that will return boolean depending on the execution of another method" do
    lambda { @object.booleanize(:verify!, :rescue => ReadyException) }.should_not raise_error
    lambda { @object.verify? }.should raise_error
    @object.ready = false
    lambda { @object.verify? }.should_not raise_error
    @object.verify?.should be_false
    @object.reason_not_verify.should eql "Not ready"
    @object.ready = true
    lambda { @object.verify? }.should_not raise_error
    @object.verify?.should be_true
    @object.reason_not_verify.should be_nil
  end
  
end
