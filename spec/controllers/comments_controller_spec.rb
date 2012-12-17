require 'spec_helper'

describe CommentsController do

  let(:comment) { mock_model(Comment) }

  describe "post :create" do
    it "should be false annonymous access" do
      post :create
      response.code.should eq "302"
    end

    describe "authenticated" do
      before :each do
        user = login_user
        Comment.should_receive(:new).and_return(comment)
        comment.should_receive(:user=).with(user)
        comment.should_receive(:to_json).and_return("{}")
      end

      context "when the comment saves successfully" do
        before :each do
          comment.should_receive(:save).and_return(true) 
          post :create
        end
        it "should be {}" do
          response.body.should eq "{}"
        end
      end

      context "when the comment fails to save" do
        before :each do 
          comment.should_receive(:save).and_return(false) 
        end

        it "format is html should be {}" do
          post :create
          response.body.should eq "{}"
        end

        it "format is json should be {}" do
          post :create, format: :json
          response.body.should eq "{}"
        end
      end
    end
  end

  describe "get index" do
    before :each do
      Comment.should_receive(:page).and_return([])
    end

    it "returns http success" do
      get :index
      response.should be_success
    end

    it "format is html and return render_template index" do
      get :index
      response.should render_template 'index'
    end

    it "format is json and not return render_template index" do
      get :index, format: :json
      response.should_not render_template 'index'
    end

    it "assigns @comments should be []" do
      get :index
      assigns[:comments].should == []
    end

  end

end
