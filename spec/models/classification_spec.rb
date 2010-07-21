require 'spec_helper'

describe Classification do
  before :each do
    @valid_attributes = {
        :account => mock_model(Account, 'destroyed?'=>false),
        :name => 'value for name'
    }
  end

  it "should create a new instance given valid attributes" do
    lambda{ Classification.create(@valid_attributes) }.should change(Classification, :count).by(1)
  end

  [:account, :name].each do |required_attr|
    it "should require a #{required_attr}" do
      @valid_attributes.delete required_attr
      lambda{ Classification.create(@valid_attributes) }.should_not change(Classification, :count)
    end
  end
end
