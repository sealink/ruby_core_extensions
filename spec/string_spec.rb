describe String do

  it "should convert to underscore replacing spaces with underscores" do
    "CamelCase UPPERCASE to be_Converted".proper_underscore.should eql "camel_case_uppercase_to_be_converted"
  end

  it 'should separate numbers and letters' do
    'abc123'.separate_numbers_and_letters.should == 'abc 123'
    '123Abc'.separate_numbers_and_letters.should == '123 Abc'

    # The following should also work but doesn't
    # '1A2b3c'.separate_numbers_and_letters.should == '1 A 2 b 3 c'
  end

  it "should convert new lines to <br /> tags" do
    "Line 1\nLine2\nLine3".nl2br.should eql "Line 1<br />Line2<br />Line3"
  end

  it 'should squash' do
    text = 'Adelaide University'
    text.squash(30).should == 'Adelaide University'
    text.squash(10).should == 'Adela Univ'
    text.squash(7).should == 'Ade Uni'
    text.squash(6).should == 'Ade Un'
    text.squash(5).should == 'Ad Un'
    text.squash(4).should == 'Ad U'
    text.squash(3).should == 'AU'
    text.squash(2).should == 'AU'
    text.squash(1).should == 'A'

    text = 'University South Australia'
    text.squash(30).should == 'University South Australia'
    text.squash(10).should == 'Uni Sou Au'
    text.squash(9).should == 'Uni So Au'
    text.squash(8).should == 'Un So Au'
    text.squash(7).should == 'Un So A'
    text.squash(6).should == 'Un S A'
    text.squash(5).should == 'USA'
    text.squash(4).should == 'USA'
    text.squash(3).should == 'USA'
    text.squash(2).should == 'US'
    text.squash(1).should == 'U'
  end

  it 'should convert to bool' do
    't'.to_bool.should == true
    'true'.to_bool.should == true
    'y'.to_bool.should == true
    'yes'.to_bool.should == true
    '1'.to_bool.should == true

    'f'.to_bool.should == false
    'false'.to_bool.should == false
    'n'.to_bool.should == false
    'no'.to_bool.should == false
    '0'.to_bool.should == false
    ''.to_bool.should == false

    expect { 'a'.to_bool }.to raise_error(ArgumentError)
  end

end
