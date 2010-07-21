require 'spec_helper'

describe ScheduleLink do
  before(:each) do
    @valid_attributes = {
      :team => mock_model(Team, 'destroyed?'=>false),
      :url => "value for url",
      :expires_on => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    lambda{ ScheduleLink.create(@valid_attributes) }.should change(ScheduleLink, :count).by(1)
  end

  [:team, :url, :expires_on].each do |required_attr|
    it "should require a #{required_attr}" do
      @valid_attributes.delete required_attr
      lambda{ ScheduleLink.create(@valid_attributes) }.should_not change(ScheduleLink, :count)
    end
  end
end
