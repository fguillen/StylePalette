require_relative "test_helper"

class HelperTest < MiniTest::Unit::TestCase
  def setup
    ColorPalette.palettes_config = "#{FIXTURES}/color_palettes.json"
  end

  def test_label
    assert_equal("<span class=\"label\" style=\"background-color: #f5abd5; color: #000\">a</span>", ColorPalette::Helper.label("a", :tags))
  end
end