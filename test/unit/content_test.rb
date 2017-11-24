require "test_helper"
require 'find'

class ContentTest < Minitest::Test
  context "meta tags" do
    should "have country specific titles" do
      content = "<title>Getting started with Sharesight | Sharesight New Zealand Help</title>"
      assert_match /#{content}/, read("build/au/getting-started-with-sharesight/index.html")

      content = "<title>Getting started with Sharesight | Sharesight Australia Help</title>"
      assert_match /#{content}/, read("build/nz/getting-started-with-sharesight/index.html")

      content = "<title>Getting started with Sharesight | Sharesight Canada Help</title>"
      assert_match /#{content}/, read("build/ca/getting-started-with-sharesight/index.html")

      content = "<title>Getting started with Sharesight | Sharesight UK Help</title>"
      assert_match /#{content}/, read("build/uk/getting-started-with-sharesight/index.html")

      content = "<title>Getting started with Sharesight | Sharesight Help</title>"
      assert_match /#{content}/, read("build/getting-started-with-sharesight/index.html")
    end
  end
end
