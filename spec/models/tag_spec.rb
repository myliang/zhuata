require 'spec_helper'

describe Tag do
  let(:tag) { FactoryGirl.create(:tag) }

  describe "instance methods" do

    it "counter default should be 1" do
      tag.counter.should == 1
    end

    describe "class methods" do
      describe "update_counter" do
        it "with 1 and raise ArgumentError" do
          expect { Tag.update_counter(1, 1) }.to raise_error(ArgumentError)
        end

        it "with rails and by_name return is not null" do
          Tag.update_counter("rails", 1)
          Tag.find_by_name("rails").should_not be_nil
        end

        it "with tag and count return 2 " do
          Tag.update_counter(tag.name, 1)
          Tag.find_by_name(tag.name).counter.should == 2
        end

        it "with [java, rails] and have 3 items" do
          Tag.update_counter(["java", "rails"], 1)
          Tag.all.should have(3).items
        end
      end
    end


  end
  after :each do
    tag.destroy
  end
end
