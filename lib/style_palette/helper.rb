module StylePalette::Helper
  def self.label(word, palette_name)
    style = StylePalette.brush(word, palette_name).style
    "<span class=\"label\" style=\"#{style}\">#{word}</span>"
  end
end