require 'spec_helper'

describe Message do

  subject { FactoryGirl.create(:message) }

  specify { subject.errors.should be_empty }

  its(:state) { should == 0 }

  its(:to_user) { should_not be_nil }
  its(:from_user) { should_not be_nil }

  specify { subject.to_user.unread_messages_count.should == 1 }

end
