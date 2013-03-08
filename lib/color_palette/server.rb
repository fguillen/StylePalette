require "sinatra/base"
require "erb"

require_relative "../color_palette"

if ARGV.empty?
  puts "Use: `XXX <palettes_file_path>`"
  exit 1
end

ColorPalette.palettes_config = ARGV.first

class ColorPalette::Server < Sinatra::Base
  include ERB::Util

  get "/" do
    @palettes = ColorPalette.palettes
    erb File.read("#{File.dirname(__FILE__)}/server_template.html.erb")
  end

  get "/add_word" do
    ColorPalette::Helper.label(params[:word], params[:palette])
  end
end

ColorPalette::Server.run!