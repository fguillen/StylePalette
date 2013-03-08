require_relative "test_helper"

class ColorPaletteTest < MiniTest::Unit::TestCase
  def setup
    ColorPalette.palettes_config = "#{FIXTURES}/color_palettes.json"
  end

  def test_color
    assert_equal("#f5abd5" , ColorPalette.color("a", :tags).background )
    assert_equal("#e7abf5" , ColorPalette.color("b", :tags).background )
    assert_equal("#b2a6f5" , ColorPalette.color("c", :tags).background )
    assert_equal("#f5acb0" , ColorPalette.color("d", :tags).background )
    assert_equal("#f5abd5" , ColorPalette.color("e", :tags).background )

    assert_equal("#000" , ColorPalette.color("a", :tags).foreground )
  end

  def test_color_by_regex
    assert_equal("#cd8745" , ColorPalette.color("active", :states).background )
    assert_equal("#82d37c" , ColorPalette.color("deactive", :states).background )
    assert_equal("#90a26b" , ColorPalette.color("blocked", :states).background )
  end

  def test_color_by_regex_numbers
    assert_equal("zero" , ColorPalette.color(0, :number).background )
    assert_equal("negative" , ColorPalette.color(-10, :number).background )
    assert_equal("positive" , ColorPalette.color(10, :number).background )
  end

  def test_color_by_regex_boolean
    assert_equal("yes" , ColorPalette.color(true, :boolean).background )
    assert_equal("yes" , ColorPalette.color(1, :boolean).background )
    assert_equal("yes" , ColorPalette.color("yes", :boolean).background )

    assert_equal("no" , ColorPalette.color(false, :boolean).background )
    assert_equal("no" , ColorPalette.color(0, :boolean).background )
    assert_equal("no" , ColorPalette.color("no", :boolean).background )

    assert_equal("yes" , ColorPalette.color("other", :boolean).background )
  end

  def test_raise_error_if_palette_name_not_found
    exception =
      assert_raises(ArgumentError) do
        ColorPalette.color("a", :not_found)
      end

    assert_match(/Palette not found/, exception.message)
  end

  def test_raise_error_if_palettes_not_initialized
    ColorPalette.instance_variable_set(:@palettes, nil)

    exception =
      assert_raises(Exception) do
        ColorPalette.color("a", :tags)
      end

    assert_match(/Palettes not initialized/, exception.message)
  end
end