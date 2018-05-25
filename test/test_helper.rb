require "minitest/autorun"
require "minitest/unit"
require "mocha/setup"

require_relative "../lib/style_palette"

class MiniTest::Unit::TestCase
  FIXTURES = File.expand_path("#{File.dirname(__FILE__)}/fixtures")
end

