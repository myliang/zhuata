require 'spec_helper'

describe Fiction do
  let(:fiction) { FactoryGirl.create(:fiction) }

  it "errors should be empty" do
    fiction.errors.should be_empty
  end
end
