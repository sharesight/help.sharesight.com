require 'maxitest/autorun'
require 'shoulda-context'
require 'middleman'
require "contentful_middleman"
require "middleman-autoprefixer"
require "middleman-syntax"
 #
 # $LOAD_PATH.unshift File.join File.expand_path(File.dirname(__FILE__)), "..", "source"

# Requiring custom test helpers
Dir[File.dirname(__FILE__) + "/helpers/*.rb"].sort.each { |f| require File.expand_path(f) }
