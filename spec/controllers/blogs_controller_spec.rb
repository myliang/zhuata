require 'spec_helper'

describe BlogsController do

  let(:blog){ mock_model(Blog) }

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

      it "assigns blog should be empty" do
        assigns[:blogs].should be_empty
      end

      it "build_params should have key :order " do
        controller.build_params.should have_key(:order)
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
