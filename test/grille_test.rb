require_relative "test_helper"
require_relative "../lib/color_palette/grille"

class GrilleTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def setup
    ColorPalette.palettes_config = "#{FIXTURES}/color_palettes.json"
  end

  def app
    ColorPalette::Grille
  end

  def test_index
    get "/"
    assert_match "<li class=\"label\" style=\"background-color: #cd8745; color: #000\">#&lt;OpenStruct background=&quot;#cd8745&quot;, foreground=&quot;#000&quot;&gt;</li>", last_response.body
  end

  def test_add_word
    get "/add_word", :word => "test", :palette_name => "tags"
    assert_equal "<span class=\"label\" style=\"background-color: #f5acb0; color: #000\">test</span>", last_response.body
  end
end