#encoding: utf-8
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

    describe "tags_to_a" do
      it "param is nil should be Array" do
        Content.tags_to_a(nil).should be_a_kind_of(Array)
      end

      it "param is ruby should be Array that have 1 element " do
        Content.tags_to_a("ruby").should have(1).items
      end

      it "param is ruby,rails，testing should be Array that have 3 element" do
        Content.tags_to_a("ruby,rails，testing q").should have(3).items
      end
    end
  end

  describe "instance methods"do 
    let(:content) { 
      Tag.should_receive(:update_counter).once
      FactoryGirl.create(:content) 
    }

    it "errors should be empty" do
      content.errors.should be_empty
    end

    it "user should be not nil" do
      content.user.should_not be_nil
    end

    it "tags should be array" do
      content.tags.should be_a_kind_of(Array)
    end

    it "tags shold be include 2 element" do
      content.tags.should have(3).items
    end

    # stub
    it "before_create should be class Tag.update_counter" do
    end


    it "update_read_counter should be read_counter + 1" do
      content.read_counter.should == 0
      content.update_read_counter
      Content.find(content.id).read_counter.should == 1
    end

    describe "short_text" do
      it "should be ge TEXT_CUT_LENGTH" do
        content.short_text.length.should <= Content::TEXT_CUT_LENGTH + 3
      end

      it "should be eq text length" do
        content.text = "ni hao world"
        content.short_text.length.should == content.text.length + 3
      end

      it "should not be include html tag" do
        content.text = "<p>you are friends</p>"
        content.short_text.should == "you are friends..."
      end
    end
    after :each do
      content.user.destroy
      content.destroy
    end
  end

end
