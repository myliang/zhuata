#encoding: utf-8
require 'spec_helper'

with_html = "<html>are <strong>you ready?</strong></html>"
return_html = "are you ready?"
with_html_2 = "<br/>hello world!"
return_html_2 = "hello world!"

describe StringHelper do
  describe "cut_remove_html" do
    it "with abc and return  abc" do
      cut_remove_html("abc"). == "abc"
    end

    it "with abc, 2 and return  ab" do
      cut_remove_html("abc", 2). == "ab"
    end

    it "with #{with_html} and return  #{return_html}" do
      cut_remove_html(with_html). == return_html
    end

    it "with #{with_html}, 3 and return  are" do
      cut_remove_html(with_html, 3). == "are"
    end

    it "with #{with_html_2} and return  #{return_html_2}" do
      cut_remove_html(with_html_2). == return_html_2
    end

    it "with #{with_html_2}, 5 and return  hello" do
      cut_remove_html(with_html_2, 5). == "hello"
    end

    it "width hello<br/> and return  hello" do
      cut_remove_html("hello<br/>"). == "hello"
    end
    it "width hello<br> and return  hello" do
      cut_remove_html("hello<br>"). == "hello"
    end
    it "width <br>hello and return  hello" do
      cut_remove_html("<br>hello"). == "hello"
    end
  end
end
