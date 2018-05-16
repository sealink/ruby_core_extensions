require 'spec_helper'

describe Enumerable do

  it 'allow mapping elements to hashes with method names of the returned values for each method' do
    expect([1, 2, 3].map_methods(:to_s, :to_f)).to eq(
      [{ to_s: '1', to_f: 1.0 }, { to_s: '2', to_f: 2.0 }, { to_s: '3', to_f: 3.0 }]
    )
  end


  context 'when detecting and returning the block value' do
    it { expect([1, 2, 3].detect_and_return { |number| number.even? && number * number }).to eq 4 }
    it { expect([1, 3, 5].detect_and_return { |number|
      number.even? && number * number }).to be nil
    }
  end


  it 'should allow selecting by attribute' do
    one = double(name: 'one', type: 'odd')
    two = double(name: 'two', type: 'even')
    thr = double(name: 'thr', type: 'odd')
    expect([one, two, thr].select_by_attr(:type, 'odd')).to eq [one, thr]
    expect([one, two, thr].select_by_attr(:type, 'even')).to eq [two]
  end

end
