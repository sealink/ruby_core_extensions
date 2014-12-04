require 'spec_helper'

describe Numeric do

  it 'should know 0 is false and 1 is true' do
    0.to_bool.should be false
    0.0.to_bool.should be false
    0.1.to_bool.should be true
    1.to_bool.should be true
  end

end
