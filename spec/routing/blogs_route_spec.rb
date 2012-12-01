require 'spec_helper'

describe "routes for Blogs" do
  it "routes /blogs/tag/ruby to tag action" do
    {get: "/blogs/tag/ruby"}.should route_to(controller: "blogs", action: "tag", tags: "ruby")
  end
end
