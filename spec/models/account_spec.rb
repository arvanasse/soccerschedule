require 'spec_helper'

describe Account do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    lambda{ Account.create(@valid_attributes) }.should change(Account, :count).by(1)
  end

  it "should require a name" do
    @valid_attributes.delete :name
    lambda{ Account.create(@valid_attributes) }.should_not change(Account, :count)
  end
end
