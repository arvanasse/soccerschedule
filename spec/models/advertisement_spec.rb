require 'spec_helper'

describe Advertisement do
  before(:each) do
    @valid_attributes = {
      :account => mock_model(Account, 'destroyed?'=>false),
      :company => "value for name",
      :title => 'value for title',
      :orientation => 'horizontalvertical',
      :description => "value for description",
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

  describe '#state' do
    before :each do
      @advertisement = Advertisement.create(@valid_attributes)
    end

    it "should default to pending" do
      @advertisement.should be_pending
    end

    context "when pending" do
      before :each do
        @advertisement.should be_pending
      end

      it "should become active when activated" do
        lambda{ @advertisement.activate }.should change(@advertisement, :state).to('active')
      end
    end

    context "when active" do
      before :each do 
        @advertisement.activate
        @advertisement.should be_active
      end

      it "should become inactive if suspended" do
        lambda{ @advertisement.suspend }.should change(@advertisement, :state).to('inactive')
      end
    end

    context "when inactive" do
      before :each do 
        @advertisement.activate
        @advertisement.suspend
        @advertisement.should be_inactive
      end

      it "should become inactive if suspended" do
        lambda{ @advertisement.activate }.should change(@advertisement, :state).to('active')
      end
    end
  end
end
