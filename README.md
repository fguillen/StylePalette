![color_palette](https://raw.github.com/fguillen/ColorPalette/master/etc/color_palette.png)

# ColorPalette

When you have a bunch of _tags_ and you want to render them in a colorize way you can implement your own colorize system or you can use **ColorPallete**.

ColorPalette offers a json based configured color collections that can be associate with words.

ColorPalette offers also helpers to render already styled `<label>` elements.



## Installation

    gem "color_palette"

## Usage

    ColorPalette.color(<word>, <palette_name>)

    ColorPalette.color("cat", :tags).background # => #f5abd5
    ColorPalette.color("cat", :tags).foreground # => #000
    ColorPalette::Helper.style("cat", :tags)) # => background-color: #f5abd5; color: #000;
    ColorPalette::Helper.label("cat", :tags)) # => <span class="label" style="background-color: #f5abd5; color: #000">cat</span>

## Configuration & Initialization

Create a _json_ file with the name of the **palettes** and with an array of _colorized_ styles for each palette, like this:

    {
      "states": [
        { "background": "#cd8745", "foreground": "#000" },
        { "background": "#82d37c", "foreground": "#000" },
        { "background": "#81dbde", "foreground": "#000" }
      ],

      "tags": [
        { "background": "#f5acb0", "foreground": "#000" },
        { "background": "#f5abd5", "foreground": "#000" },
        { "background": "#e7abf5", "foreground": "#000" },
        { "background": "#b2a6f5", "foreground": "#000" }
      ]
    }

Check a [configuration example file](https://github.com/fguillen/ColorPalette/blob/master/etc/color_palettes.example.json).

Then initialize ColorPalette this way:

    ColorPalette.palettes_config = <palettes_file_path.json>

## Word/Color assignment

In the basic configuration ColorPallete takes a random _color_ for each _word_ (always the same color for each word), this is very helpful when you don't really care about the associated color for each word, for example if you have docens of _tags_ you are not gonna assign one specific color to each _tag_ just create a big enough palette and let ColorPalette to choose.

But if you want to _force_ a color for an specific word you can do it using the special _regex_ attribute for a color in this way:

    "states": [
      { "background": "#cd8745", "foreground": "#000" },
      { "background": "#82d37c", "foreground": "#000" },
      { "background": "#81dbde", "foreground": "#000", "regex": "blocked" }
    ],

Now if the _word_ is **blocked** then the last color is gonna be choosen.

As you can guess, any valid _regex_ can be used in this field.

Check the [examples in the tests](https://github.com/fguillen/ColorPalette/blob/master/test/color_palette_test.rb)

## The Grille web page

ColorPallete comes with a usefull _command_ that you can use to test your _palettes_ in an adhoc web page:

	gem install sinatra # if not installed yet
    color_palette_grille <palettes_file_path.json>
    open localhost:4567

(You should install `sinatra` gem first due is not part of the required dependencies.)




