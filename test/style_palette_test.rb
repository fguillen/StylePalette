require_relative "test_helper"

class StylePaletteTest < MiniTest::Unit::TestCase
  def setup
    StylePalette.palettes_config = "#{FIXTURES}/style_palettes.json"
  end

  def test_style
    assert_equal("style 10" , StylePalette.brush("a", :tags).style )
    assert_equal("style 11" , StylePalette.brush("b", :tags).style )
    assert_equal("style 12" , StylePalette.brush("c", :tags).style )
    assert_equal("style 9" , StylePalette.brush("d", :tags).style )
    assert_equal("style 10" , StylePalette.brush("e", :tags).style )
  end

  def test_style_by_regex
    assert_equal("style 1" , StylePalette.brush("active", :states).style )
    assert_equal("style 2" , StylePalette.brush("deactive", :states).style )
    assert_equal("style 4" , StylePalette.brush("blocked", :states).style )
  end

  def test_style_by_range
    assert_equal("style 13" , StylePalette.brush("-10", :ranges).style )
    # assert_equal("style 14" , StylePalette.brush("0", :ranges).style )
    # assert_equal("style 14" , StylePalette.brush("20", :ranges).style )
    # assert_equal("style 15" , StylePalette.brush("40", :ranges).style )
    # assert_equal("style 16" , StylePalette.brush("85", :ranges).style )
    # assert_equal("style 16" , StylePalette.brush("99999", :ranges).style )
  end

  def test_style_by_regex_numbers
    assert_equal("style 4" , StylePalette.brush(0, :number).style )
    assert_equal("style 6" , StylePalette.brush(-10, :number).style )
    assert_equal("style 5" , StylePalette.brush(10, :number).style )
  end

  def test_style_by_regex_boolean
    assert_equal("style 7" , StylePalette.brush(true, :boolean).style )
    assert_equal("style 7" , StylePalette.brush(1, :boolean).style )
    assert_equal("style 7" , StylePalette.brush("yes", :boolean).style )

    assert_equal("style 8" , StylePalette.brush(false, :boolean).style )
    assert_equal("style 8" , StylePalette.brush(0, :boolean).style )
    assert_equal("style 8" , StylePalette.brush("no", :boolean).style )

    assert_equal("style 7" , StylePalette.brush("other", :boolean).style )
  end

  def test_raise_error_if_palette_name_not_found
    exception =
      assert_raises(ArgumentError) do
        StylePalette.brush("a", :not_found)
      end

    assert_match(/Palette not found/, exception.message)
  end

  def test_raise_error_if_palettes_not_initialized
    StylePalette.instance_variable_set(:@palettes, nil)

    exception =
      assert_raises(Exception) do
        StylePalette.brush("a", :tags)
      end

    assert_match(/Palettes not initialized/, exception.message)
  end

  def test_palettes_config_actually_call_paletter_config_json
    StylePalette.expects(:palettes_config_json).with("json content")
    StylePalette.palettes_config = "#{FIXTURES}/file.json"
  end
end