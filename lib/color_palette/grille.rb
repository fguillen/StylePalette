require "sinatra/base"
require "erb"

class ColorPalette::Grille < Sinatra::Base
  include ERB::Util

  get "/" do
    @palettes = ColorPalette.palettes
    erb File.read("#{File.dirname(__FILE__)}/server_template.html.erb")
  end

  get "/add_word" do
    ColorPalette::Helper.label(params[:word], params[:palette])
  end
end