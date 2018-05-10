require 'spec_helper'

describe Hash do
  before do
    @sub_array1 = [3, BigDecimal('4'), Date.new(2000, 1, 1), DateTime.new(2000, 1, 1, 0, 0, 0), { :f => 5 }]
    @sub_array2 = [3, BigDecimal('4'), Date.new(2000, 1, 1), DateTime.new(2000, 1, 1, 0, 0, 0), { 'f' => 5 }]
    @hash1 = { :a  => 1, :b  => { :c  => 2 }, :d => 'test', :e  => @sub_array1 }
    @hash2 = { 'a' => 1, 'b' => { 'c' => 2 }, :d => 'test', 'e' => @sub_array2 }
  end

  it "should allow converting all values to strings recursively" do
    expect(@hash1.stringify_values_recursively).to eq({ :a => "1", :b => { :c => "2" }, :d => "test", :e => ["3", '4.0', "2000-01-01", '2000-01-01T00:00:00+00:00', { :f => "5" }] })
  end

  it "should allow converting all keys to symbols recursively" do
    expect(@hash2.symbolize_keys_recursively).to eq @hash1
  end

  it "should allow converting keys" do
    expect(@hash1.convert_keys(&:to_s)).to eq({ "a" => 1, "b" => { :c => 2 }, "d" => "test", "e" => @sub_array1 })
  end

  it "should allow converting values" do
    expect(@hash1.convert_values(&:to_s)).to eq({ :a => "1", :b => { :c => 2 }, :d => "test", :e => @sub_array1 })
  end

  it "should allow converting values only for specific keys" do
    expect(@hash1.convert_values(:d, :e, &:to_s)).to eq({ :a => 1, :b => { :c => 2 }, :d => "test", :e => @sub_array1 })
  end

  it "should allow making indifferent access recursively" do
    expect(@hash1.make_indifferent_access_recursively['b']['c']).to eq 2
    expect(@hash1.make_indifferent_access_recursively['e'][4]['f']).to eq 5
  end

  it "should allow executing blocks recursively" do
    hash = { :a => 1, :b => { :a => 2 }, :c => { :a => 3, :b => 4, :c => { :a => 5 } } }
    result = []
    hash.recursively do |k, v|
      result << v unless v.is_a?(Hash)
    end
    expect(result.sort).to eq [1, 2, 3, 4, 5] # Ruby 1.8.7 doesn't order hash keys
  end
end

describe Hash do
  it 'should allow removing all nil values and return a new hash' do
    expect({ :a => 1, :b => nil }.compact).to eq({ :a => 1 })
  end

  it 'should allow removing all nil values' do
    a = { :a => 1, :b => nil }
    a.compact!
    expect(a).to eq({ :a => 1 })
  end

  it 'should allow removing all nil values and return a new hash' do
    expect({ :a => 1, :b => '' }.compact_blank).to eq({ :a => 1 })
  end

  it 'should allow removing all blank values' do
    a = { :a => 1, :b => '' }
    a.compact_blank!
    expect(a).to eq({ :a => 1 })
  end

  it 'should allow removing all blank values recursively' do
    a = { :a => 1, :b => { :c => 1, :d => '', :e => [] } }
    a.recursive_compact_blank!
    expect(a).to eq({ :a => 1, :b => { :c => 1 } })
  end

  it 'should allow extracting subsets' do
    a = { :a => 1, :b => 2, :c => 3 }
    b = a.extract!(:a, :c)
    expect(b).to eq({ :a => 1, :c => 3 })
    expect(a).to eq({ :b => 2 })
  end
end

describe Hash, '#map_key_value' do
  subject { { '1' => '2', 3 => 4 } }

  it 'should map key' do
    expect(subject.map_key(:to_i)).to eq({ 1 => '2', 3 => 4 })
  end

  it 'should map value' do
    expect(subject.map_value(:to_i)).to eq({ '1' => 2, 3 => 4 })
  end

  it 'should map key and value' do
    expect(subject.map_key_value(:to_i, :to_i)).to eq({ 1 => 2, 3 => 4 })
  end

  it 'should map key and value if value not specified' do
    expect(subject.map_key_value(:to_i)).to eq({ 1 => 2, 3 => 4 })
  end
end
