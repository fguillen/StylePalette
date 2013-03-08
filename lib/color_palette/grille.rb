require "sinatra/base"
require "erb"

class ColorPalette::Grille < Sinatra::Base
  include ERB::Util

  set :raise_errors, true
  set :show_exceptions, false

  get "/" do
    @palettes = ColorPalette.palettes
    erb File.read("#{File.dirname(__FILE__)}/grille_template.html.erb")
  end

  get "/add_word" do
    ColorPalette::Helper.label(params[:word], params[:palette_name])
  end
end