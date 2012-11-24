require 'spec_helper'

describe Reply do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:reply){ FactoryGirl.create(:reply) }
  let(:child1){ FactoryGirl.build(:reply) }
  let(:child2){ FactoryGirl.build(:reply) }

  it "errors should be empty" do
    reply.errors.should be_empty
  end

  it "children should be empty" do
    reply.children.should be_empty
  end

  describe "children" do
    before :each do
      reply.children = [child1, child2]
    end

    it "child1 should be new_record?" do
      child1.new_record?.should be_true
    end

    it "should be have 2 children" do
      reply.children.should have(2).items
    end

    it "first element should be child1" do
      reply.children[0].should == child1
    end

    describe "add replay to first element" do
      before :each do
        reply.children[0].children << child2
      end

      it "children should have 1 element" do
        reply.children[0].children.should have(1).items
      end

      it "children [0] should be child2" do
        reply.children[0].children[0].should == child2
      end
    end
  end

end
