require 'spec_helper'

describe Enumerable do
  it '#map_methods' do
    expect([1, 2, 3].map_methods(:to_s, :to_f)).to eq [
      { to_s: '1', to_f: 1.0 },
      { to_s: '2', to_f: 2.0 },
      { to_s: '3', to_f: 3.0 }
    ]
  end

  context 'when detecting and returning the block value' do
    subject {
      input.detect_and_return { |number| number.even? && number * number }
    }

    context 'when matching value' do
      let(:input) { [1, 2, 3] }
      it { is_expected.to eq 4 }
    end

    context 'when no matching value' do
      let(:input) { [1, 3, 5] }
      it { is_expected.to be nil }
    end
  end

  it 'should allow selecting by attribute' do
    one = double(name: 'one', type: 'odd')
    two = double(name: 'two', type: 'even')
    thr = double(name: 'thr', type: 'odd')
    expect([one, two, thr].select_by_attr(:type, 'odd')).to eq [one, thr]
    expect([one, two, thr].select_by_attr(:type, 'even')).to eq [two]
  end
end
