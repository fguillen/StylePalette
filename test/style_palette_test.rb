require_relative "test_helper"

class StylePaletteTest < MiniTest::Unit::TestCase
  def setup
    StylePalette.palettes_config = "#{FIXTURES}/style_palettes.json"
  end

  def test_color
    assert_equal("#f5abd5" , StylePalette.color("a", :tags).background )
    assert_equal("#e7abf5" , StylePalette.color("b", :tags).background )
    assert_equal("#b2a6f5" , StylePalette.color("c", :tags).background )
    assert_equal("#f5acb0" , StylePalette.color("d", :tags).background )
    assert_equal("#f5abd5" , StylePalette.color("e", :tags).background )

    assert_equal("#000" , StylePalette.color("a", :tags).foreground )
  end

  def test_color_by_regex
    assert_equal("#cd8745" , StylePalette.color("active", :states).background )
    assert_equal("#82d37c" , StylePalette.color("deactive", :states).background )
    assert_equal("#90a26b" , StylePalette.color("blocked", :states).background )
  end

  def test_color_by_regex_numbers
    assert_equal("zero" , StylePalette.color(0, :number).background )
    assert_equal("negative" , StylePalette.color(-10, :number).background )
    assert_equal("positive" , StylePalette.color(10, :number).background )
  end

  def test_color_by_regex_boolean
    assert_equal("yes" , StylePalette.color(true, :boolean).background )
    assert_equal("yes" , StylePalette.color(1, :boolean).background )
    assert_equal("yes" , StylePalette.color("yes", :boolean).background )

    assert_equal("no" , StylePalette.color(false, :boolean).background )
    assert_equal("no" , StylePalette.color(0, :boolean).background )
    assert_equal("no" , StylePalette.color("no", :boolean).background )

    assert_equal("yes" , StylePalette.color("other", :boolean).background )
  end

  def test_raise_error_if_palette_name_not_found
    exception =
      assert_raises(ArgumentError) do
        StylePalette.color("a", :not_found)
      end

    assert_match(/Palette not found/, exception.message)
  end

  def test_raise_error_if_palettes_not_initialized
    StylePalette.instance_variable_set(:@palettes, nil)

    exception =
      assert_raises(Exception) do
        StylePalette.color("a", :tags)
      end

    assert_match(/Palettes not initialized/, exception.message)
  end
end