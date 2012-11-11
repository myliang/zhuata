require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  describe "save" do
    before do
      user.save.should be_true
    end

    it "should be no errors" do
      user.errors.should be_empty
    end
  end

  after :each do
    user.destroy
  end
end
