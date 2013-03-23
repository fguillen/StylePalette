require "sinatra/base"
require "erb"

class StylePalette::Grille < Sinatra::Base
  include ERB::Util

  set :raise_errors, true
  set :show_exceptions, false

  get "/" do
    @palettes = StylePalette.palettes
    erb File.read("#{File.dirname(__FILE__)}/grille_template.html.erb")
  end

  get "/add_word" do
    "<li>#{StylePalette::Helper.label(params[:word], params[:palette_name])}</li>"
  end
end