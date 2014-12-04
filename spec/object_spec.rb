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
    expect { @object.virtual_belongs_to(:test_model) }.to_not raise_error
    expect { @object.test_model = TestModel.new }.to_not raise_error
    expect(@object.test_model_id).to eq 1
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
    expect { @object.booleanize(:verify!, :rescue => ReadyException) }.to_not raise_error
    expect { @object.verify? }.to raise_error
    @object.ready = false
    expect { @object.verify? }.to_not raise_error
    expect(@object.verify?).to be false
    expect(@object.reason_not_verify).to eq "Not ready"
    @object.ready = true
    expect { @object.verify? }.to_not raise_error
    expect(@object.verify?).to be true
    expect(@object.reason_not_verify).to be nil
  end

end
