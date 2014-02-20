require 'spec_helper'

describe Location do
  it "Has a valid location factory" do
    l = FactoryGirl.create(:location)
    l.valid?

  end

  it "is invalid without name"
  it "has association with distributor"
  it "has association with sales"
end


