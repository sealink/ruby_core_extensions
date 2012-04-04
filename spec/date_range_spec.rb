require 'spec_helper'

describe Range, "overlapping with other ranges" do

  it "should detect overlaps" do
    # 1-------10
    #             20-------30
    (1..10).overlaps?(20..30).should be_false

    #             20-------30
    # 1-------10
    (20..30).overlaps?(1..10).should be_false
  
    # 1-------10
    #         10-------20
    (1...10).overlaps?(10..20).should be_true

    # 1-----------15
    #         10-------20
    (1..15).overlaps?(10..20).should be_true

    #     5--------15
    # 1-------10
    (5..15).overlaps?(1..10).should be_true
    
    #         10--------20
    # 1-------10
    (10..20).overlaps?(1..10).should be_true
  end
end

