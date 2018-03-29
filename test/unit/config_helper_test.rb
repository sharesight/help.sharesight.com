require "test_helper"
require File.expand_path(File.dirname(__FILE__) + "/../../helpers/config_helper")

class ConfigHelperTest < Minitest::Test
  context "get_locale_from_url" do
    should "return supported locales" do
      assert_equal "/nz", ConfigHelper.get_locale_from_url("/nz/getting-started-with-sharesight/")
      assert_equal "/au", ConfigHelper.get_locale_from_url("/au/getting-started-with-sharesight/")
      assert_equal "/ca", ConfigHelper.get_locale_from_url("/ca/getting-started-with-sharesight/")
      assert_equal "/uk", ConfigHelper.get_locale_from_url("/uk/getting-started-with-sharesight/")
      assert_equal "", ConfigHelper.get_locale_from_url("/getting-started-with-sharesight/")
    end
  end



  context "urls" do
    setup do
      I18n.config.enforce_available_locales = false
    end

    context "help_page_url_slug" do
      should "return manual slug when present" do
        correct_slug = "correct-slug"
        page1 = fake_object(url_slug: { en: "/#{correct_slug}/" }, title: { en: "WRONG!"})
        assert_equal correct_slug, ConfigHelper.help_page_url_slug(page1)
      end

      should "return slug of title when no manual slug present" do
        correct_slug = "correct-slug"
        page2 = fake_object(url_slug: { en: nil }, title: { en: correct_slug })
        assert_equal correct_slug, ConfigHelper.help_page_url_slug(page2)
      end

      should "strip slashes, downcase, replace spaces with dashes, make url-safe" do
        page3 = fake_object(url_slug: { en: nil }, title: { en: "/WTF is GoiNg on here?/" })
        assert_equal "wtf-is-going-on-here", ConfigHelper.help_page_url_slug(page3)
      end
    end

    context "help_category_url_slug" do
      should "return slug of name" do
        category = fake_object(name: { en: "correct slug" })
        assert_equal "correct-slug", ConfigHelper.help_category_url_slug(category)
      end
    end

    context "slugify" do
      should "return a slug" do
        assert_equal "correct-slug", ConfigHelper.slugify(" CoRrect--slug ")
      end

      should "return a slug with no spaces" do
        assert_equal "correct-slug", ConfigHelper.space_slugify(" correct slug ")
      end
    end

  end
end
