require 'spec_helper'

describe Blog do
  let(:blog){ FactoryGirl.create(:blog) }

  it "errors should be empty" do
    blog.errors.should be_empty
  end

  it "user blogs_count should be 1" do
    # blog.user.blogs_count.should == 1
  end

  after :each do
    Blog.destroy_all
    User.destroy_all
  end

end
