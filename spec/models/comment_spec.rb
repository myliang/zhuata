require 'spec_helper'

describe Comment do

  let(:comment) { FactoryGirl.build(:comment) }
  let(:blog_comment) { FactoryGirl.create(:blog_comment) }

  it "save should be false" do
    comment.save.should be_false
  end

  it "blog comment should have not errors" do
    blog_comment.errors.should be_empty
  end

  it "comments_count should be +1" do
    puts ":::::::::#{blog_comment.commentable.to_json}"
    puts ":::::::::#{blog_comment.user.to_json}"
    # blog_comment.commentable.comments_count.should == 1
  end

  it "commentable_type should be == Blog" do
    blog_comment.commentable_type.should == "Blog"
  end

  after :each do
    Comment.destroy_all
    User.destroy_all
  end

end
