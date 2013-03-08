require "json"
require "ostruct"
require_relative "color_palette/version"

module ColorPalette
  def self.test_palettes( file_path = nil )
    result = ""

    palettes.each do |palette_name, palette|
      result += "<h1>#{palette_name}</h1>"
      result += "<ul>"
      palette.each do |color|
        result += "<li style=\"background-color: #{color[:background]}; color: #{color[:foreground]}\">#{color[:background]}</li>"
      end
      result += "</ul>"
    end

    if( file_path )
      File.open( file_path, "w" ) { |f| f.write result }
    end

    result
  end

  def self.color(word, palette_name)
    raise ArgumentError, "palette not found '#{palette_name}'" unless palettes[palette_name]

    word = word.to_s
    color_by_regex(word, palette_name) || color_by_index(word, palette_name)
  end

  def self.color_by_regex(word, palette_name)
    palettes[palette_name].select{ |e| e.regex && word =~ /#{e.regex}/  }.to_a[0]
  end

  def self.color_by_index(word, palette_name)
    index = word.each_byte.inject( &:+ )
    palettes[palette_name][ index % palettes[palette_name].length ]
  end

  def self.palettes_config=(color_palettes_file_path)
    palettes = {}

    JSON.parse(File.read(color_palettes_file_path)).each do |palette_name, palette|
      palettes[palette_name.to_sym] = palette.map { |e| OpenStruct.new(e) }
    end

    @palettes = palettes
  end

  def self.palettes
    @palettes
  end
end