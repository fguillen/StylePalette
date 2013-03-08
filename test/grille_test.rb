require_relative "test_helper"

class GrilleTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    ColorPalette::Server
  end

  def test_index
    get "/"
    assert_equal 'Hello World!', last_response.body
  end

  def test_add_word
    get "/add_word", :word => "test", :palette_name => "tags"
    assert_equal 'Hello Frank!', last_response.body
  end
end