![style_palette](https://raw.github.com/fguillen/StylePalette/master/etc/style_palette.png)

# StylePalette

When you have a bunch of _tags_ and you want to render them in a colorize way you can implement your own colorize system or you can use **StylePalette**.

StylePalette offers a json based configured color collections that can be associate with words.

StylePalette offers also helpers to render already styled `.label` elements.

## The Gallery playground

You can check your _style palettes_ in the [StylePaletteGallery](http://stylepalettegallery.herokuapp.com/) or [fork the app](https://github.com/fguillen/StylePaletteGallery) and create your own playground.

## Installation

    gem "style_palette"

## Usage

    StylePalette.brush(<word>, <palette_name>)

    StylePalette.brush("cat", :tags).style #=> "color: #f5abd5;"
    StylePalette.brush("cat", :tags).background # => #f5abd5
    StylePalette.brush("cat", :tags).foreground # => #000
    StylePalette::Helper.style("cat", :tags) # => color: #f5abd5;
    StylePalette::Helper.label("cat", :tags) # => <span class="badge" style="color: #f5abd5;">cat</span>

## Configuration & Initialization

Create a _json_ file with the name of the **palettes** and with an array of _colorized_ styles for each palette, like this:

    {
      "states": [
        { "style": "color: #cd8745;" },
        { "style": "color: #82d37c;" },
        { "style": "color: #81dbde;" }
      ],

      "tags": [
        { "style": "color: #f5acb0;" },
        { "style": "color: #f5abd5;" },
        { "style": "color: #e7abf5;" },
        { "style": "color: #b2a6f5;" }
      ]
    }

Check a [configuration example file](https://github.com/fguillen/StylePalette/blob/master/etc/style_palettes.example.json).

Then initialize StylePalette this way:

    StylePalette.palettes_config = <palettes_file_path.json>

## Rails integration

Configuration:

    # config/style_palettes.json
    {
      "states": [
        { "style": "background-color: #cd8745; color: #000;" },
        { "style": "background-color: #82d37c; color: #000;" },
        { "style": "background-color: #81dbde; color: #000;" }
      ]
    }

Initialization:

    # config/initializers/style_palette.rb
    StylePalette.palettes_config = "#{Rails.root}/config/style_palettes.json"

Helper:

    # app/helpers/application_helper.rb
    def render_label(word, palette_name)
      StylePalette::Helper.label(word, palette_name).html_safe
    end

    def render_labels(words, palette_name)
      words.map { |e| render_label e, palette_name }.join(" ").html_safe
    end

Use:

    # in any template
    <%= render_label(current_user.state, :states) %>


## Word/Color assignment

In the basic configuration StylePalette takes a random _color_ for each _word_ (**always the same color for each word**), this is very helpful when you don't really care about the associated color for each word, for example if you have docens of _tags_ you are not gonna assign one specific color to each _tag_ just create a big enough palette and let StylePalette to choose.

But if you want to _force_ a color for an specific word you can do it using the special _regex_ attribute for a color in this way:

    "states": [
      { "style": "background-color: #cd8745; color: #000;" },
      { "style": "background-color: #82d37c; color: #000;" },
      { "style": "background-color: #81dbde; color: #000;", "regex": "blocked" }
    ],

Now if the _word_ is **blocked** then the last color is gonna be choosen.

As you can guess, any valid _regex_ can be used in this field.

Check the [examples in the tests](https://github.com/fguillen/StylePalette/blob/master/test/style_palette_test.rb)

Also check the next examples:

### Number assignment

  	"number": [
  	  { "style": "background-color: #CCCCCC; color: #000;", "regex": "^0$" },
  	  { "style": "background-color: #91E391; color: #000;", "regex": "^[^-]" },
  	  { "style": "background-color: #E68585; color: #000;", "regex": "^-" }
  	],

  	StylePalette::Helper.label(0, :number) # => <span class="badge" style="background-color: #CCCCCC; color: #000;">0</span>
  	StylePalette::Helper.label(123, :number) # => <span class="badge" style="background-color: #91E391; color: #000;">123</span>
  	StylePalette::Helper.label(-99, :number) # => <span class="badge" style="background-color: #E68585; color: #000;">-99</span>

* For _zero_ the first color will be choosen
* For _positive numbers_ the second color will be choosen
* For _negative numbers_ the last color while be choosen

### Range assignment

    "ranges": [
      { "style": "background-color: #fff385; color: #000;", "range": "..0" },
      { "style": "background-color: #85ffd0; color: #000;", "range": "0..20" },
      { "style": "background-color: #85c2ff; color: #000;", "range": "20..80" },
      { "style": "background-color: #ff85f3; color: #000;", "range": "80.." }
    ]

    StylePalette::Helper.label(0, :ranges) # => <span class="badge" style="background-color: #fff385; color: #000;">0</span>
    StylePalette::Helper.label(45, :ranges) # => <span class="badge" style="background-color: #85c2ff; color: #000;">45</span>

### Boolean assignment

  	"boolean": [
  	  { "style": "background-color: #91E391; color: #000;", "regex": "^(yes|1|true)$" },
  	  { "style": "background-color: #E68585; color: #000;", "regex": "^(no|0|false)$" }
  	],

  	StylePalette::Helper.label(0, :boolean) # => <span class="badge" style="background-color: #91E391; color: #000;">0</span>
  	StylePalette::Helper.label("no", :boolean) # => <span class="badge" style="background-color: #91E391; color: #000;">no</span>
  	StylePalette::Helper.label("yes", :boolean) # => <span class="badge" style="background-color: #E68585; color: #000;">yes</span>
  	StylePalette::Helper.label(true, :boolean) # => <span class="badge" style="background-color: #E68585; color: #000;">true</span>


### Other structures

We can use another structures that are not just simple `style`:

    // style_palettes.json
    "categories": [
        { "name": "primary", "color": "#673ab7" },
        { "name": "success", "color": "#32ab13" },
        { "name": "danger", "color": "#f02769" }
    ],

    // Other place
    StylePalette.brush("word", :categories).name # => primary
    StylePalette.brush("word", :categories).color # => "#673ab7"
