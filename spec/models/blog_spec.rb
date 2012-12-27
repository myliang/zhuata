# coding: utf-8
require 'spec_helper'

describe Blog do
  let(:blog){ FactoryGirl.create(:blog) }

  it "errors should be empty" do
    blog.errors.should be_empty
  end

  it "user blogs_count should be 1" do
    blog.user.blogs_count.should == 1
  end

  it "param Blog.new should be BlogTag" do
    blog.tag_class.should == BlogTag
  end

  describe "tags_to_a" do

    it "param is nil should be Array" do
      blog.new_tags = nil
      blog.new_tags_to_a.should be_a_kind_of(Array)
    end

    it "param is ruby should be Array that have 1 element " do
      blog.new_tags = "ruby"
      blog.new_tags_to_a.should have(1).items
    end

    it "param is ruby,rails，testing should be Array that have 3 element" do
      blog.new_tags = "ruby,rails，testing q"
      blog.new_tags_to_a.should have(3).item
    end
  end

  describe "validates" do
    let(:content){  FactoryGirl.build(:blog) }
    it "#title max length <= 30" do
      content.title = 31.times.collect { "a" }
      content.save.should be_false
      content.should have(1).error_on(:title)
    end

    it "#title must be required" do
      content.title = nil
      content.save.should be_false
      content.should have(1).error_on(:title)
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

  end

end
