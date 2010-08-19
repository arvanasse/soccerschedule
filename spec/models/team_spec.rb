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

  describe '#state' do
    it "should default to visible" do
      @team = Team.new(@valid_attributes)
      @team.should be_visible
    end

    context 'when visible' do
      before :each do
        @team = Team.new(@valid_attributes)
        @team.should be_visible
      end

      it "should become hidden when invoking hide" do
        lambda{ @team.hide }.should change(@team, :state).to('hidden')
      end
    end

    context 'when hidden' do
      before :each do
        @team = Team.create(@valid_attributes)
        @team.hide
        @team.should be_hidden
      end

      it "should become hidden when invoking hide" do
        lambda{ @team.show }.should change(@team, :state).to('visible')
      end
    end
  end
end
