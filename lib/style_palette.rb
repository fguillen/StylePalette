require "json"
require "ostruct"

require_relative "style_palette/version"
require_relative "style_palette/helper"

module StylePalette
  attr_reader :palettes_config

  def self.brush(word, palette_name)
    word = word.to_s
    palette_name = palette_name.to_sym

    raise ArgumentError, "Palette not found '#{palette_name}'" unless palettes[palette_name]
    brush_by_regex(word, palette_name) || brush_by_range(word, palette_name) || brush_by_index(word, palette_name)
  end

  def self.brush_by_regex(word, palette_name)
    palettes[palette_name].select{ |e| e.regex && word =~ /#{e.regex}/  }.first
  end

  def self.brush_by_range(word, palette_name)
    palettes[palette_name].select do |e|
      result = false

      if e.range
        from = e.range.split("..")[0].length > 0 ? e.range.split("..")[0].to_i : -Float::INFINITY
        to = e.range.split("..")[1] ? e.range.split("..")[1].to_i : Float::INFINITY
        result = (from..to).include?(word.to_i)
      end

      result
    end.to_a.first
  end

  def self.brush_by_index(word, palette_name)
    index = word.each_byte.inject( &:+ )
    palettes[palette_name][ index % palettes[palette_name].length ]
  end

  def self.palettes_config=(style_palettes_file_path)
    style_palettes_json = File.read(style_palettes_file_path)
    palettes_config_json style_palettes_json
  end

  def self.palettes_config
    @palettes_config
  end

  def self.palettes_config_json(style_palettes_json)
    @palettes_config = style_palettes_json

    palettes = {}

    JSON.parse(style_palettes_json).each do |palette_name, palette|
      palettes[palette_name.to_sym] = palette.map { |e| OpenStruct.new(e) }
    end

    @palettes = palettes
  end

  def self.reset
    @palettes = nil
    @palettes_config = nil
  end

  def self.palettes
    @palettes || raise(Exception, "Palettes not initialized, try `StylePalette.palettes_config = <file_path>`")
  end
end