require 'spec_helper'

describe Class do

  it 'should downcase class name to symbol' do
    class CamelCaseClass; end

    Object.downcase_symbol.should == :object
    CamelCaseClass.downcase_symbol.should == :camelcaseclass
  end

end
