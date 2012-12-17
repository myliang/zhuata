require 'spec_helper'

describe BlogsController do

  let(:blog){ mock_model(Blog) }
  let(:comment){ mock_model(Comment) }

  describe "protected methods" do
    let(:controller) { BlogsController.new }

    it "model_class should be Blog" do
      controller.send(:model_class).should == Blog
    end

    it "model_name should be blog" do
      controller.send(:model_name).should == "blog"
    end

    it "instance_model_name should be nil" do
      controller.send(:instance_model_name).should be_nil
    end

    it "instance_model_name should be " do
      controller.send(:instance_model_name_set, blog)
      controller.send(:instance_model_name).should eq blog
    end

  end

  describe "GET 'new'" do

    it "should be false anonymous access" do
      get 'new'
      response.code.should eq "302"
    end

    describe "authenticated" do
      before :each do
        login_user
        Blog.should_receive(:new).and_return(blog)
        get "new"
      end

      it "returns http success" do
        response.should be_success
      end
      it "should render new" do
        response.should render_template("new")
      end
      it "assigns @blog should not be nil" do
        assigns[:blog].should eq blog
      end
    end

  end

  describe "GET 'show'" do
    before :each do
      Blog.stub(:find).with(blog.id.to_s).and_return(blog)
      blog.should_receive(:update_read_count)
      Comment.should_receive(:new).and_return(comment)
      get 'show', id: blog.id
    end

    it "returns http success" do
      response.should be_success
    end
    it "should render show" do
      response.should render_template("show")
    end
    it "assigns @blog should be blog" do
      assigns[:blog].should eq blog
    end
    it "assigns @comment should be comment" do
      assigns[:comment].should eq comment
    end

  end

  describe "GET 'edit'" do
    it "should be false anonymous access" do
      get 'edit'
      response.code.should eq "302"
    end

    describe "authenticated" do
      before :each do
        login_user
        Blog.should_receive(:find).with(blog.id.to_s).and_return(blog)
        get "edit", id: blog.id
      end

      it "returns http success" do
        response.should be_success
      end
      it "should render edit" do
        response.should render_template("edit")
      end
      it "assigns @blog should be blog" do
        assigns[:blog].should eq blog
      end
    end
  end

  describe "POST 'create'" do

    it "should be false anonymous access" do
      post :create
      response.code.should eq "302"
    end

    describe "authenticated" do
      context "when the blog fails to save" do
        it "should render_template new" do
          login_user
          post :create
          response.should render_template "new"
        end

      end
      context "when the blog saves successfully" do

        before :each do
          user = login_user
          attrs = FactoryGirl.attributes_for(:simple_blog)
          Blog.should_receive(:new).and_return(blog)
          blog.should_receive(:user=).with(user)
          blog.should_receive(:save).and_return(true)

          post :create, blog: attrs
        end

        it "should redirect to show" do
          response.should redirect_to blog_path(blog)
        end
        it "assigns @blog should be blog" do
          assigns[:blog].should eq blog
        end
      end
    end
  end

  describe "put 'update'" do
    it "should be false anonymous access" do
      put :update
      response.code.should eq "302"
    end

    describe "authenticated" do
      context "when the blog fails to update" do
        it "should render_template edit" do
          login_user
          put :update
          response.should render_template "edit"
        end

      end
      context "when the blog updates successfully" do

        before :each do
          user = login_user
          attrs = {}
          attrs["title"] = "title update"
          Blog.should_receive(:find).with(blog.id.to_s).and_return(blog)
          blog.should_not_receive(:user=)
          blog.should_receive(:update_attributes).with(attrs).and_return(true)

          put :update, id: blog.id, blog: attrs
        end

        it "should redirect to show" do
          response.should redirect_to blog_path(blog)
        end
        it "assigns @blog should be blog" do
          assigns[:blog].should eq blog
        end
      end
    end
  end

  describe "DELETE :destroy" do
    it "should be false anonymous access" do
      put :update
      response.code.should eq "302"
    end

    describe "authenticated" do
      before :each do
        login_user
        Blog.should_receive(:find).with(blog.id.to_s).and_return(blog)
        delete :destroy, id: blog.id
      end
      it "assigns @blog is nil" do
        assigns[:blog].should eq blog
      end
      specify { response.should redirect_to blogs_url }
    end
  end

  describe "GET 'tag'" do
    before :each do
      controller.should_receive(:index)
      get "tag"
    end

    it "returns http success" do
      response.should be_success
    end
    it "should render index" do
      response.should render_template("index")
    end
  end

  describe "GET 'index'" do
    context "no params" do

      before :each do
        Blog.should_receive(:page).and_return([])
        controller.should_not_receive(:build_model)
        get 'index'
      end

      it "returns http success" do
        response.should be_success
      end

      it "should render index" do
        response.should render_template("index")
      end

      it "assigns @blogs should be empty" do
        assigns[:blogs].should be_empty
      end

    end

  end

end
