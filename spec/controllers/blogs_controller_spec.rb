require 'spec_helper'

describe BlogsController do
  before :each do
    login_user
  end

  let(:blog){ mock_model(Blog) }
  let(:comment){ mock_model(Comment) }

  describe "protected methods" do
    let(:controller) { BlogsController.new }

    it "model_class should be Blog" do
      controller.model_class.should == Blog
    end

    it "model_name should be blog" do
      controller.model_name.should == "blog"
    end

    it "instance_model_name should be nil" do
      controller.instance_model_name.should be_nil
    end

    it "instance_model_name should be " do
      controller.instance_model_name_set(blog)
      controller.instance_model_name.should eq blog
    end

  end

  describe "GET 'new'" do

    it "should be false anonymous access" do
      get 'new'
      # response.should be_false
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
      # response.should be_false
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
      post 'create'
      # response.should be_false
    end

    describe "authenticated" do
      before :each do
        user = login_user
        attrs = FactoryGirl.attributes_for(:simple_blog)
        Blog.should_receive(:new).and_return(blog)
        blog.should_receive(:user=).with(user)
        blog.should_receive(:save).and_return(true)

        post "create", blog: attrs
      end

      it "returns http success" do
        response.should_not be_success
      end
      it "should redirect to show" do
        response.should redirect_to blog_path(blog)
      end
      it "assigns @blog should be blog" do
        assigns[:blog].should eq blog
      end
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

      it "build_params should have key :order " do
        controller.build_params.should have_key(:order)
      end

      it "build_params should not include controller and action" do
        controller.build_params.should_not have_key(:controller)
        controller.build_params.should_not have_key(:action)
      end
    end

    context "params with tags: ruby" do
      before :each do
        get 'index', {tags: "ruby"}
      end

      it "build_params should have key :tags" do
        controller.build_params.should have_key(:tags)
      end
    end

  end

end
