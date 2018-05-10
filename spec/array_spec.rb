require 'spec_helper'

describe Array do
  it "should allow converting all values to strings recursively" do
    @now = Time.now
    expect([1, 2, @now, [3, 4]].stringify_values_recursively).to eq ['1', '2', @now.to_s, ['3', '4']]
  end

  it "should allow removing all blank values" do
    a = [1, nil, 3, '']
    a.compact_blank!
    expect(a).to eq [1, 3]
  end

  it "should allow removing all blank values recursively" do
    a = [1, 2, [" Kan", {}], nil, { a: "", b: {} }, ["garoos", " "]]
    a.recursive_compact_blank!
    expect(a.join).to eq "12 Kangaroos"
  end

  it "should allow verifying if all elements are blank recursively" do
    expect(['', nil, [nil, ['']]]).to be_recursive_blank
    expect(['', nil, [nil, ['', 1]]]).to_not be_recursive_blank
  end

  it "should allow converting to hash given a key" do
    expect([1, 2, 3].hash_by(:ordinalize)).to eq('1st' => 1, "2nd" => 2, "3rd" => 3)
    expect([1, 2, 3].hash_by(:ordinalize, :to_s)).to eq('1st' => '1', "2nd" => '2', "3rd" => '3')
    expect([1, 2, 3].hash_by(:ordinalize) { |v| v + 1 }).to eq('1st' => 2, "2nd" => 3, "3rd" => 4)
    expect([1, 2, 3].hash_by { |k| k * 2 }).to eq(2 => 1, 4 => 2, 6 => 3)
  end

  it "should allow executing blocks recursively" do
    array = [1, [2, 3], [4, [5, 6], 7, [8]], 9, [[10]]]
    result = []
    array.recursively do |e|
      result << e unless e.is_a?(Array)
    end
    expect(result).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  end

  it '#intersects?' do
    array1 = [1, 2, 3]
    array2 = [3, 4, 5]
    array3 = [6, 7, 8]

    expect(array1.intersects?(array2)).to be true
    expect(array1.intersects?(array3)).to be false
    expect(array2.intersects?(array3)).to be false

    array1same = [1, 2, 3]
    expect(array1.intersects?(array1same)).to be true
  end

  it '#first' do
    expect(Array.first([])).to be nil
    expect(Array.first([4, 2])).to eq 4
    expect(Array.first(4)).to eq 4
  end

  it '#last' do
    expect(Array.last([])).to be nil
    expect(Array.last([4, 2])).to eq 2
    expect(Array.last(4)).to eq 4
  end
end
