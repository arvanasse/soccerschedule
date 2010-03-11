require 'spec_helper'

describe ScheduleLink do
  before(:each) do
    @valid_attributes = {
      :team_id => 1,
      :url => "value for url",
      :expires_on => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    ScheduleLink.create!(@valid_attributes)
  end
end
