describe String do
  it 'should convert to underscore replacing spaces with underscores' do
    expect('CamelCase UPPERCASE to be_Converted'.proper_underscore).to eq 'camel_case_uppercase_to_be_converted'
  end

  it 'should separate numbers and letters' do
    expect('abc123'.separate_numbers_and_letters).to eq 'abc 123'
    expect('123Abc'.separate_numbers_and_letters).to eq '123 Abc'

    # The following should also work but doesn't
    # '1A2b3c'.separate_numbers_and_letters.should == '1 A 2 b 3 c'
  end

  it 'should convert new lines to <br /> tags' do
    expect("Line 1\nLine2\nLine3".nl2br).to eq 'Line 1<br />Line2<br />Line3'
  end

  it 'should squash' do
    text = 'Adelaide University'
    expect(text.squash(30)).to eq 'Adelaide University'
    expect(text.squash(10)).to eq 'Adela Univ'
    expect(text.squash(7)).to eq 'Ade Uni'
    expect(text.squash(6)).to eq 'Ade Un'
    expect(text.squash(5)).to eq 'Ad Un'
    expect(text.squash(4)).to eq 'Ad U'
    expect(text.squash(3)).to eq 'AU'
    expect(text.squash(2)).to eq 'AU'
    expect(text.squash(1)).to eq 'A'

    text = 'University South Australia'
    expect(text.squash(30)).to eq 'University South Australia'
    expect(text.squash(10)).to eq 'Uni Sou Au'
    expect(text.squash(9)).to eq 'Uni So Au'
    expect(text.squash(8)).to eq 'Un So Au'
    expect(text.squash(7)).to eq 'Un So A'
    expect(text.squash(6)).to eq 'Un S A'
    expect(text.squash(5)).to eq 'USA'
    expect(text.squash(4)).to eq 'USA'
    expect(text.squash(3)).to eq 'USA'
    expect(text.squash(2)).to eq 'US'
    expect(text.squash(1)).to eq 'U'
  end

  it 'should convert to bool' do
    expect('t'.to_bool).to eq true
    expect('true'.to_bool).to eq true
    expect('y'.to_bool).to eq true
    expect('yes'.to_bool).to eq true
    expect('1'.to_bool).to eq true

    expect('f'.to_bool).to eq false
    expect('false'.to_bool).to eq false
    expect('n'.to_bool).to eq false
    expect('no'.to_bool).to eq false
    expect('0'.to_bool).to eq false
    expect(''.to_bool).to eq false

    expect { 'a'.to_bool }.to raise_error(ArgumentError)
  end
end
