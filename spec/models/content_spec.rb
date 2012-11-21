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
      Tag.should_receive(:update_counter).exactly(1 * CALL_TIMES).times
      FactoryGirl.create(:content) 
    }

    it "update Tag.update_counter should at least 2 times" do
      Tag.should_receive(:update_counter).exactly(2 * CALL_TIMES).times
      content.update_attributes(:title => "new title").should be_true
    end

    it "read_count should be default 0" do
      content.read_count.should == 0
    end

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

    it "update_read_count should be read_count + 1" do
      content.read_count.should == 0
      content.update_read_count
      Content.find(content.id).read_count.should == 1
    end

    after :each do
      Content.destroy_all
      User.destroy_all
    end
  end

end
