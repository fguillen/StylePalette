module ColorPalette::Helper
  def self.label(word, palette_name)
    color = ColorPalette.color(word, palette_name)
    style = "background-color: #{color.background}; color: #{color.foreground}"
    "<span class=\"label\" style=\"#{style}\">#{word}</span>"
  end
end