module StylePalette::Helper
  def self.label(word, palette_name)
    style = StylePalette.brush(word, palette_name).style
    "<span class=\"badge\" style=\"#{style}\">#{word}</span>"
  end
end
