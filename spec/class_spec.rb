require 'spec_helper'

describe Class do

  it 'should downcase class name to symbol' do
    class CamelCaseClass; end

    expect(Object.downcase_symbol).to eq :object
    expect(CamelCaseClass.downcase_symbol).to eq :camelcaseclass
  end

end
