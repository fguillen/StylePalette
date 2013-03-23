module StylePalette::Helper
  def self.label(word, palette_name)
    style = style(word, palette_name)
    "<span class=\"label\" style=\"#{style}\">#{word}</span>"
  end

  def self.style(word, palette_name)
    color = StylePalette.color(word, palette_name)
    "background-color: #{color.background}; color: #{color.foreground};"
  end
end