require 'spec_helper'

describe Blog do

  let(:blog) { FactoryGirl.build(:blog) }

  it "save no errors" do
    blog.save.should be_true
    blog.errors.should be_empty
    blog.user.should_not be_nil
  end

  after :each do
    blog.user.destroy
    blog.destroy
  end
end
