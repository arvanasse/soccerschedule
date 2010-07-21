require 'spec_helper'

describe User do
  before :each do
    @valid_attributes = {
      :account => mock_model(Account, 'destroyed?' => false),
      :name => 'value for name',
      :email => 'value@email.com',
      :password => 'welcome',
      :password_confirmation => 'welcome',
      :admin => false,
      :reminders => false
    }
  end

  it "should create an instance given valid attributes" do
    lambda{ User.create(@valid_attributes) }.should change(User, :count).by(1)
  end

  [:account, :email, :password, :password_confirmation].each do |required_attr|
    it "should require a #{required_attr}" do
      @valid_attributes.delete required_attr
      lambda{ User.create(@valid_attributes) }.should_not change(User, :count)
    end
  end
end

