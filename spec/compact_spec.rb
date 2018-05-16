describe Array, 'compact' do
  it 'should compact blank' do
    a = [1, nil, 3]
    a.compact_blank!
    expect(a).to eq [1, 3]
  end

  it 'should recursive compact blank' do
    a = [1, nil, { a: nil, b: 2 }]
    a.recursive_compact_blank!
    expect(a).to eq [1, { b: 2 }]

    b = [1, nil, { a: nil }]
    b.recursive_compact_blank!
    expect(b).to eq [1]
  end
end

describe Hash, 'compact' do
  it 'should compact' do
    expect({ a: 1, b: nil }.compact).to eq({ a: 1 })
  end

  it 'should compact!' do
    a = { a: 1, b: nil }
    a.compact!
    expect(a).to eq({ a: 1 })
  end

  it 'should compact blank' do
    expect({ a: 1, b: '' }.compact_blank).to eq({ a: 1 })
  end

  it 'should compact blank!' do
    a = { a: 1, b: '' }
    a.compact_blank!
    expect(a).to eq({ a: 1 })
  end

  it 'should recursive compact blank!' do
    a = { a: 1, b: { c: 1, d: '' } }
    a.recursive_compact_blank!
    expect(a).to eq({ a: 1, b: { c: 1 } })

    a = { a: 1, b: { c: [], d: '' } }
    a.recursive_compact_blank!
    expect(a).to eq({ a: 1 })
  end
end
