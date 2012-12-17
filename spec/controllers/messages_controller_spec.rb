require 'spec_helper'

describe MessagesController do

  describe 'get :to' do
    it "should be false anonymous access" do
      get :to
      response.code.should eq "302"
    end

    describe "authenticated" do
      before :each do
        user = login_user
        controller.should_receive(:current_user).and_return(user)
        user.should_receive(:receive_messages).and_return([])
        get 'to'
      end

      it "returns http success" do
        response.should be_success
      end
      it "should render to" do
        response.should render_template("to")
      end
      it "assigns @messages should be []" do
        assigns[:messages].should eq []
      end
    end
  end
  describe 'get :from' do
    it "should be false anonymous access" do
      get :from
      response.code.should eq "302"
    end

    describe "authenticated" do
      before :each do
        user = login_user
        controller.should_receive(:current_user).and_return(user)
        user.should_receive(:send_messages).and_return([])
        get :from
      end

      it "returns http success" do
        response.should be_success
      end
      it "should render to" do
        response.should render_template("from")
      end
      it "assigns @messages should be []" do
        assigns[:messages].should eq []
      end
    end
  end
end
