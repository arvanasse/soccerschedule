require 'spec_helper'

describe Advertisement do
  before(:each) do
    @valid_attributes = {
      :account => mock_model(Account, 'destroyed?'=>false),
      :company => "value for name",
      :title => 'value for title',
      :orientation => 'horizontalvertical',
      :description => "value for description",
      :state => "value for state",
      :url => "value for url"
    }
  end

  it "should create a new instance given valid attributes" do
    lambda{Advertisement.create(@valid_attributes)}.should change(Advertisement, :count).by(1)
  end

  [:account, :company, :url].each do |required_attr|
    it "should require a #{required_attr}" do
      @valid_attributes.delete required_attr
      lambda{Advertisement.create(@valid_attributes)}.should_not change(Advertisement, :count)
    end
  end
end
