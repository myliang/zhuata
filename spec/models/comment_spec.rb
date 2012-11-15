require 'spec_helper'

describe Comment do

  let(:comment) { FactoryGirl.build(:comment) }
  let(:blog_comment) { FactoryGirl.create(:blog_comment) }

  it "save should be false" do
    comment.save.should be_false
  end

  it "blog comment save should have not errors" do
    blog_comment.errors.should be_empty
  end

  it "commentable_type should be == Blog" do
    blog_comment.commentable_type.should == "Blog"
  end

  after :each do
    Comment.destroy_all
    User.destroy_all
  end

end
