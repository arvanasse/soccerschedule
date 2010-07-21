require 'spec_helper'

describe Team do
  before :each do
    @valid_attributes = {
      :account => mock_model(Account, 'destroyed?' => false),
      :classification => mock_model(Classification, 'destroyed?'=>false),
      :name => 'value for name'
    }
  end

  it "should create a new instance given valid attributes" do
    lambda{ Team.create(@valid_attributes) }.should change(Team, :count).by(1)
  end

  [:account, :classification, :name].each do |required_attr|
    it "should require a #{required_attr}" do
      @valid_attributes.delete required_attr
      lambda{ Team.create(@valid_attributes) }.should_not change(Team, :count)
    end
  end
end
