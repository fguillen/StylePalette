require_relative "test_helper"

class HelperTest < MiniTest::Unit::TestCase
  def setup
    StylePalette.palettes_config = "#{FIXTURES}/style_palettes.json"
  end

  def test_label
    assert_equal("<span class=\"label\" style=\"background-color: #f5abd5; color: #000;\">a</span>", StylePalette::Helper.label("a", :tags))
  end
end