require 'spec_helper'

describe Comment do

  let(:comment) { FactoryGirl.build(:comment) }

  it "save should be false" do
    comment.save.should be_false
  end

  describe "blog comment" do
    let(:blog_comment) { FactoryGirl.create(:blog_comment) }
    let(:reply) { FactoryGirl.create(:reply) }

    describe "replies" do
      before :each do
        blog_comment.replies << reply
      end

      it "should have 1 items" do
        blog_comment.replies.should have(1).items
      end
    end

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

end
