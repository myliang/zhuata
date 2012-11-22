require 'spec_helper'

describe Comment do

  let(:comment) { FactoryGirl.build(:comment) }

  it "save should be false" do
    comment.save.should be_false
  end

  describe "blog comment" do
    let(:blog_comment) { FactoryGirl.create(:blog_comment) }

    it "blog comment should have not errors" do
      blog_comment.errors.should be_empty
    end

    it "commentable comments_count should be 1" do
      blog_comment.commentable.comments_count.should == 1
    end

    it "user comments_count should be 1" do
      blog_comment.user.comments_count.should == 1
    end

    it "commentable_type should be == Blog" do
      blog_comment.commentable_type.should == "Blog"
    end

  end

  after :each do
    Comment.destroy_all
    Content.destroy_all
    User.destroy_all
  end

end
