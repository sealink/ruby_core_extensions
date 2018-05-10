describe File do
  it 'remove bad characters' do
    expect(safe('john*test.jpg')).to eq 'john-test.jpg'
    expect(safe(' Betty Boop-*StarHyphen')).to eq '-Betty-Boop-StarHyphen'
    expect(safe('What The Hotel?')).to eq 'What-The-Hotel-'
  end

  it 'should prittify & to and' do
    expect(safe('Guns & Roses')).to eq 'Guns-and-Roses'
    expect(safe('& They Lived')).to eq 'and-They-Lived'
  end

  def safe(from)
    File.safe_name(from)
  end
end
