require 'spec_helper'

describe Content do

  # class methods
  describe "class methods" do
    describe "tag_class" do
      it "param Content.new should be Tag" do
        Content.tag_class(Content.new).should == Tag
      end

      it "param Blog.new should be BlogTag" do
        Content.tag_class(Blog.new).should == BlogTag
      end
    end
  end

  describe "instance methods"do 
    let(:content) { FactoryGirl.build(:content) }

    before :each do
      content.save.should be_true
    end

    describe "validater" do

      it "errors should be empty" do
        content.errors.should be_empty
      end

      it "user should be not nil" do
        content.user.should_not be_nil
      end

    end

    describe "short_text" do
      it "should be ge TEXT_CUT_LENGTH" do
        content.short_text.length.should >= Content::TEXT_CUT_LENGTH
      end
    end

    after :each do
      content.user.destroy
      content.destroy
    end
  end

end
