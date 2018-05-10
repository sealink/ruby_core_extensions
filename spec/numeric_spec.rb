require 'spec_helper'

describe Numeric do
  it 'should know 0 is false and 1 is true' do
    expect(0.to_bool).to be false
    expect(0.0.to_bool).to be false
    expect(0.1.to_bool).to be true
    expect(1.to_bool).to be true
  end
end
