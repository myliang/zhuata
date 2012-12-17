require 'spec_helper'

include MongoMapper::Plugins::Pagination::ClassMethods

describe "MongoMapper extend" do
  let(:default_hash) { {order: :created_at.desc, per_page: 10, page: 1} }
  describe ".build_page_params" do
    it "with nil and return DEFAULT_HASH" do
      hash = build_page_params(nil)
      hash.should eq default_hash
    end

    it "with [] and return DEFAULT_HASH" do
      hash = build_page_params([])
      hash.should eq default_hash
    end

    it "with {} and return DEFAULT_HASH" do
      hash = build_page_params({})
      hash.should eq default_hash
    end

    it "with {'controller': 'blog', 'action': 'index'} and return DEFAULT_HASH" do
      params = {}
      params['controller'] = 'blog'
      params['action'] = 'index'
      hash = build_page_params(params)
      hash.should eq default_hash
    end

    it "with {controller: 'blog', action: 'index'} and return DEFAULT_HASH" do
      params = {controller: 'blog', action: 'index'}
      hash = build_page_params(params)
      hash.should eq default_hash
    end

    it "with {name: 'ruby'} and return DEFAULT_HASH + name" do
      default_hash[:name] = 'ruby'
      build_page_params({name: 'ruby'}).should eq default_hash
    end
  end
end
