describe File do
  it "remove bad characters" do
    safe("john*test.jpg").should == "john-test.jpg"
    safe(" Betty Boop-*StarHyphen").should == "-Betty-Boop-StarHyphen"
    safe("What The Hotel?").should == "What-The-Hotel-"
  end

  it "should prittify & to and" do
    safe("Guns & Roses").should == "Guns-and-Roses"
    safe("& They Lived").should == "and-They-Lived"
  end

  def safe(from)
    File.safe_name(from)
  end
end

