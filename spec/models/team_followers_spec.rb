require 'spec_helper'

describe TeamFollower do
  before :each do
    @valid_attributes = {
      :user => mock_model(User, 'destroyed?' => false),
      :team => mock_model(Team, 'destroyed?'=>false)
    }
  end

  it "should create a new instance given valid attributes" do
    lambda{ TeamFollower.create(@valid_attributes) }.should change(TeamFollower, :count).by(1)
  end

  [:team, :user].each do |required_attr|
    it "should require a #{required_attr}" do
      @valid_attributes.delete required_attr
      lambda{ TeamFollower.create(@valid_attributes) }.should_not change(TeamFollower, :count)
    end
  end
end
