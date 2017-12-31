require_relative "test_helper"

class HelperTest < MiniTest::Unit::TestCase
  def setup
    StylePalette.palettes_config = "#{FIXTURES}/style_palettes.json"
  end

  def test_label
    assert_equal("<span class=\"badge\" style=\"style 10\">a</span>", StylePalette::Helper.label("a", :tags))
  end
end
