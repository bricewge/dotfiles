# Configuration for Alacritty, the GPU enhanced terminal emulator


# Any items in the `env` entry below will be added as
# environment variables. Some entries may override variables
# set by alacritty it self.
env:
  # TERM env customization.
  #
  # If this property is not set, alacritty will set it to xterm-256color.
  #
  # Note that some xterm terminfo databases don't declare support for italics.
  # You can verify this by checking for the presence of `smso` and `sitm` in
  # `infocmp xterm-256color`.
  # TERM: xterm-256color
  TERM: alacritty-direct

window:
  # Window dimensions in character columns and lines
  # Falls back to size specified by window manager if set to 0x0.
  # (changes require restart)
  dimensions:
    columns: 80
    lines: 24

  # Adds this many blank pixels of padding around the window
  # Units are physical pixels; this is not DPI aware.
  # (change requires restart)
  padding:
    x: 2
    y: 2

  # Window decorations
  #
  # Values for `decorations`:
  #     - full: Borders and title bar
  #     - none: Neither borders nor title bar
  #
  # Values for `decorations` (macOS only):
  #     - transparent: Title bar, transparent background and title bar buttons
  #     - buttonless: Title bar, transparent background, but no title bar buttons
  decorations: full

  # Startup Mode (changes require restart)
  #
  # Values for `startup_mode`:
  #   - Windowed
  #   - Maximized
  #   - Fullscreen
  #
  # Values for `startup_mode` (macOS only):
  #   - SimpleFullscreen
  startup_mode: Windowed

scrolling:
  # Maximum number of lines in the scrollback buffer.
  # Specifying '0' will disable scrolling.
  history: 10000

  # Number of lines the viewport will move for every line scrolled when
  # scrollback is enabled (history > 0).
  multiplier: 3

  # Scroll to the bottom when new text is written to the terminal.

auto_scroll: false
# Display tabs using this many cells (changes require restart)
tabspaces: 8

# When true, bold text is drawn using the bright variant of colors.
draw_bold_text_with_bright_colors: true

# Font configuration (changes require restart)
#
# Important font attributes like antialiasing, subpixel aa, and hinting can be
# controlled through fontconfig. Specifically, the following attributes should
# have an effect:
#
# * hintstyle
# * antialias
# * lcdfilter
# * rgba
#
# For instance, if you wish to disable subpixel antialiasing, you might set the
# rgba property to "none". If you wish to completely disable antialiasing, you
# can set antialias to false.
#
# Please see these resources for more information on how to use fontconfig
#
# * https://wiki.archlinux.org/index.php/font_configuration#Fontconfig_configuration
# * file:///usr/share/doc/fontconfig/fontconfig-user.html
font:
  # The normal (roman) font face to use.
  normal:
    family: MesloLGS Nerd Font
    # Style can be specified to pick a specific face.
    # style: Regular

  # The bold font face
  bold:
    family: MesloLGS Nerd Font
    # Style can be specified to pick a specific face.
    # style: Bold

  # The italic font face
  italic:
    family: MesloLGS Nerd Font
    # Style can be specified to pick a specific face.
    # style: Italic

  # Point size of the font
  size: 11.0

  # Offset is the extra space around each character. `offset.y` can be thought of
  # as modifying the line spacing, and `offset.x` as modifying the letter spacing.
  offset:
    x: 0
    y: 0

  # Glyph offset determines the locations of the glyphs within their cells with
  # the default being at the bottom. Increasing `x` moves the glyph to the right,
  # increasing `y` moves the glyph upwards.
  glyph_offset:
    x: 0
    y: 0

  # OS X only: use thin stroke font rendering. Thin strokes are suitable
  # for retina displays, but for non-retina you probably want this set to
  # false.
  use_thin_strokes: true

# Colors
colors:
  # Default colors
  primary:
    background: 'COLOR_BACKGROUND_ALT'
    foreground: 'COLOR_FOREGROUND'

  # Colors the cursor will use if `custom_cursor_colors` is true
  cursor:
    text: 'COLOR_BACKGROUND_ALT'
    cursor: 'COLOR_FOREGROUND'

  # Normal colors
  normal:
    black:   'COLOR0'
    red:     'COLOR1'
    green:   'COLOR2'
    yellow:  'COLOR3'
    blue:    'COLOR4'
    magenta: 'COLOR5'
    cyan:    'COLOR6'
    white:   'COLOR7'

  # Bright colors
  bright:
    black:   'COLOR8'
    red:     'COLOR9'
    green:   'COLOR10'
    yellow:  'COLOR11'
    blue:    'COLOR12'
    magenta: 'COLOR13'
    cyan:    'COLOR14'
    white:   'COLOR15'

#   # Dim colors (Optional)
#   dim:
#     black:   '0x333333'
#     red:     '0xf2777a'
#     green:   '0x99cc99'
#     yellow:  '0xffcc66'
#     blue:    '0x6699cc'
#     magenta: '0xcc99cc'
#     cyan:    '0x66cccc'
#     white:   '0xdddddd'

# Bell
#
# The bell is rung every time the BEL control character is received.
bell:
  # Visual Bell Animation
  #
  # Animation effect for flashing the screen when the visual bell is rung.
  #
  # Values for `animation`:
  #   - Ease
  #   - EaseOut
  #   - EaseOutSine
  #   - EaseOutQuad
  #   - EaseOutCubic
  #   - EaseOutQuart
  #   - EaseOutQuint
  #   - EaseOutExpo
  #   - EaseOutCirc
  #   - Linear
  animation: EaseOutExpo

  # Duration of the visual bell flash in milliseconds. A `duration` of `0` will
  # disable the visual bell animation.
  duration: 100

  # Visual bell animation color.
  #color: '#ffffff'

  # Bell Command
  #
  # This program is executed whenever the bell is rung.
  #
  # When set to `command: None`, no command will be executed.
  #
  # Example:
  #   command:
  #     program: notify-send
  #     args: ["Hello, World!"]
  #
  #command: None

# Background opacity
background_opacity: 1.0

debug:
  # Display the time it takes to redraw each frame.
  render_timer: false

  # Keep the log file after quitting Alacritty.
  persistent_logging: false

  # Log level
  #
  # Values for `log_level`:
  #   - None
  #   - Error
  #   - Warn
  #   - Info
  #   - Debug
  #   - Trace
  log_level: Warn

  # Print all received window events.
  print_events: false

  # Record all characters and escape sequences as test data.
  ref_test: false

# Mouse bindings
#
# Currently doesn't support modifiers. Both the `mouse` and `action` fields must
# be specified.
#
# Values for `mouse`:
# - Middle
# - Left
# - Right
# - Numeric identifier such as `5`
#
# Values for `action`:
# - Paste
# - PasteSelection
# - Copy (TODO)
mouse_bindings:
  - { mouse: Middle, action: PasteSelection }

mouse:
  # Click settings
  #
  # The `double_click` and `triple_click` settings control the time
  # alacritty should wait for accepting multiple clicks as one double
  # or triple click.
  double_click: { threshold: 300 }
  triple_click: { threshold: 300 }

  # If this is `true`, the cursor is temporarily hidden when typing.
  hide_when_typing: false

  # url:
    # URL launcher
    #
    # This program is executed when clicking on a text which is recognized as a URL.
    # The URL is always added to the command as the last parameter.
    #
    # When set to `None`, URL launching will be disabled completely.
    #
    # Default:
    #   - (macOS) open
    #   - (Linux) xdg-open
    #   - (Windows) explorer
    #launcher:
    #  program: xdg-open
    #  args: []

    # URL modifiers
    #
    # These are the modifiers that need to be held down for opening URLs when clicking
    # on them. The available modifiers are documented in the key binding section.
  modifiers: None

selection:
  semantic_escape_chars: ",│`|:\"' ()[]{}<>"

# Allow terminal applications to change Alacritty's window title.
dynamic_title: true

cursor:
  # Cursor style
  #
  # Values for `style`:
  #   - ▇ Block
  #   - _ Underline
  #   - | Beam
  style: Block

  # If this is `true`, the cursor will be rendered as a hollow box when the
  # window is not focused.
  unfocused_hollow: true

# Live config reload (changes require restart)
live_config_reload: true

# Shell
#
# You can set shell.program to the path of your favorite shell, e.g. /bin/fish.
# Entries in shell.args are passed unmodified as arguments to the shell.
#
# shell:
#   program: /bin/bash
#   args:
#     - --login

# Key bindings
#
# Each binding is defined as an object with some properties. Most of the
# properties are optional. All of the alphabetical keys should have a letter for
# the `key` value such as `V`. Function keys are probably what you would expect
# as well (F1, F2, ..). The number keys above the main keyboard are encoded as
# `Key1`, `Key2`, etc. Keys on the number pad are encoded `Number1`, `Number2`,
# etc.  These all match the glutin::VirtualKeyCode variants.
#
# A list with all available `key` names can be found here:
# https://docs.rs/glutin/*/glutin/enum.VirtualKeyCode.html#variants
#
# Possible values for `mods`
# `Command`, `Super` refer to the super/command/windows key
# `Control` for the control key
# `Shift` for the Shift key
# `Alt` and `Option` refer to alt/option
#
# mods may be combined with a `|`. For example, requiring control and shift
# looks like:
#
# mods: Control|Shift
#
# The parser is currently quite sensitive to whitespace and capitalization -
# capitalization must match exactly, and piped items must not have whitespace
# around them.
#
# Either an `action`, `chars`, or `command` field must be present.
#   `action` must be one of `Paste`, `PasteSelection`, `Copy`, or `Quit`.
#   `chars` writes the specified string every time that binding is activated.
#     These should generally be escape sequences, but they can be configured to
#     send arbitrary strings of bytes.
#   `command` must be a map containing a `program` string, and `args` array of
#     strings. For example:
#     - { ... , command: { program: "alacritty", args: ["-e", "vttest"] } }
#
# Want to add a binding (e.g. "PageUp") but are unsure what the X sequence
# (e.g. "\x1b[5~") is? Open another terminal (like xterm) without tmux,
# then run `showkey -a` to get the sequence associated to a key combination.
key_bindings:
  - { key: V,              mods: Control|Shift,    action: Paste         }
  - { key: C,              mods: Control|Shift,    action: Copy          }
  - { key: Q,              mods: Command, action: Quit                   }
  - { key: W,              mods: Command, action: Quit                   }
  - { key: Insert,         mods: Shift,   action: PasteSelection         }
  - { key: Key0,           mods: Control, action: ResetFontSize          }
  - { key: Equals,         mods: Control, action: IncreaseFontSize       }
  - { key: NumpadSubtract, mods: Control, action: DecreaseFontSize       }
  - { key: Home,                    chars: "\x1bOH",   mode: AppCursor   }
  - { key: Home,                    chars: "\x1b[H",   mode: ~AppCursor  }
  - { key: End,                     chars: "\x1bOF",   mode: AppCursor   }
  - { key: End,                     chars: "\x1b[F",   mode: ~AppCursor  }
  - { key: PageUp,   mods: Shift,   chars: "\x1b[5;2~"                   }
  - { key: PageUp,   mods: Control, chars: "\x1b[5;5~"                   }
  - { key: PageUp,                  chars: "\x1b[5~"                     }
  - { key: PageDown, mods: Shift,   chars: "\x1b[6;2~"                   }
  - { key: PageDown, mods: Control, chars: "\x1b[6;5~"                   }
  - { key: PageDown,                chars: "\x1b[6~"                     }
  - { key: Tab,      mods: Shift,   chars: "\x1b[Z"                      }
  - { key: Back,                    chars: "\x7f"                        }
  - { key: Back,     mods: Alt,     chars: "\x1b\x7f"                    }
  - { key: Insert,                  chars: "\x1b[2~"                     }
  - { key: Delete,                  chars: "\x1b[3~"                     }
  - { key: Left,     mods: Shift,   chars: "\x1b[1;2D"                   }
  - { key: Left,     mods: Control, chars: "\x1b[1;5D"                   }
  - { key: Left,     mods: Alt,     chars: "\x1b[1;3D"                   }
  - { key: Left,                    chars: "\x1b[D",   mode: ~AppCursor  }
  - { key: Left,                    chars: "\x1bOD",   mode: AppCursor   }
  - { key: Right,    mods: Shift,   chars: "\x1b[1;2C"                   }
  - { key: Right,    mods: Control, chars: "\x1b[1;5C"                   }
  - { key: Right,    mods: Alt,     chars: "\x1b[1;3C"                   }
  - { key: Right,                   chars: "\x1b[C",   mode: ~AppCursor  }
  - { key: Right,                   chars: "\x1bOC",   mode: AppCursor   }
  - { key: Up,       mods: Shift,   chars: "\x1b[1;2A"                   }
  - { key: Up,       mods: Control, chars: "\x1b[1;5A"                   }
  - { key: Up,       mods: Alt,     chars: "\x1b[1;3A"                   }
  - { key: Up,                      chars: "\x1b[A",   mode: ~AppCursor  }
  - { key: Up,                      chars: "\x1bOA",   mode: AppCursor   }
  - { key: Down,     mods: Shift,   chars: "\x1b[1;2B"                   }
  - { key: Down,     mods: Control, chars: "\x1b[1;5B"                   }
  - { key: Down,     mods: Alt,     chars: "\x1b[1;3B"                   }
  - { key: Down,                    chars: "\x1b[B",   mode: ~AppCursor  }
  - { key: Down,                    chars: "\x1bOB",   mode: AppCursor   }
  - { key: F1,                      chars: "\x1bOP"                      }
  - { key: F2,                      chars: "\x1bOQ"                      }
  - { key: F3,                      chars: "\x1bOR"                      }
  - { key: F4,                      chars: "\x1bOS"                      }
  - { key: F5,                      chars: "\x1b[15~"                    }
  - { key: F6,                      chars: "\x1b[17~"                    }
  - { key: F7,                      chars: "\x1b[18~"                    }
  - { key: F8,                      chars: "\x1b[19~"                    }
  - { key: F9,                      chars: "\x1b[20~"                    }
  - { key: F10,                     chars: "\x1b[21~"                    }
  - { key: F11,                     chars: "\x1b[23~"                    }
  - { key: F12,                     chars: "\x1b[24~"                    }
  - { key: F1,       mods: Shift,   chars: "\x1b[1;2P"                   }
  - { key: F2,       mods: Shift,   chars: "\x1b[1;2Q"                   }
  - { key: F3,       mods: Shift,   chars: "\x1b[1;2R"                   }
  - { key: F4,       mods: Shift,   chars: "\x1b[1;2S"                   }
  - { key: F5,       mods: Shift,   chars: "\x1b[15;2~"                  }
  - { key: F6,       mods: Shift,   chars: "\x1b[17;2~"                  }
  - { key: F7,       mods: Shift,   chars: "\x1b[18;2~"                  }
  - { key: F8,       mods: Shift,   chars: "\x1b[19;2~"                  }
  - { key: F9,       mods: Shift,   chars: "\x1b[20;2~"                  }
  - { key: F10,      mods: Shift,   chars: "\x1b[21;2~"                  }
  - { key: F11,      mods: Shift,   chars: "\x1b[23;2~"                  }
  - { key: F12,      mods: Shift,   chars: "\x1b[24;2~"                  }
  - { key: F1,       mods: Control, chars: "\x1b[1;5P"                   }
  - { key: F2,       mods: Control, chars: "\x1b[1;5Q"                   }
  - { key: F3,       mods: Control, chars: "\x1b[1;5R"                   }
  - { key: F4,       mods: Control, chars: "\x1b[1;5S"                   }
  - { key: F5,       mods: Control, chars: "\x1b[15;5~"                  }
  - { key: F6,       mods: Control, chars: "\x1b[17;5~"                  }
  - { key: F7,       mods: Control, chars: "\x1b[18;5~"                  }
  - { key: F8,       mods: Control, chars: "\x1b[19;5~"                  }
  - { key: F9,       mods: Control, chars: "\x1b[20;5~"                  }
  - { key: F10,      mods: Control, chars: "\x1b[21;5~"                  }
  - { key: F11,      mods: Control, chars: "\x1b[23;5~"                  }
  - { key: F12,      mods: Control, chars: "\x1b[24;5~"                  }
  - { key: F1,       mods: Alt,     chars: "\x1b[1;6P"                   }
  - { key: F2,       mods: Alt,     chars: "\x1b[1;6Q"                   }
  - { key: F3,       mods: Alt,     chars: "\x1b[1;6R"                   }
  - { key: F4,       mods: Alt,     chars: "\x1b[1;6S"                   }
  - { key: F5,       mods: Alt,     chars: "\x1b[15;6~"                  }
  - { key: F6,       mods: Alt,     chars: "\x1b[17;6~"                  }
  - { key: F7,       mods: Alt,     chars: "\x1b[18;6~"                  }
  - { key: F8,       mods: Alt,     chars: "\x1b[19;6~"                  }
  - { key: F9,       mods: Alt,     chars: "\x1b[20;6~"                  }
  - { key: F10,      mods: Alt,     chars: "\x1b[21;6~"                  }
  - { key: F11,      mods: Alt,     chars: "\x1b[23;6~"                  }
  - { key: F12,      mods: Alt,     chars: "\x1b[24;6~"                  }
  - { key: F1,       mods: Super,   chars: "\x1b[1;3P"                   }
  - { key: F2,       mods: Super,   chars: "\x1b[1;3Q"                   }
  - { key: F3,       mods: Super,   chars: "\x1b[1;3R"                   }
  - { key: F4,       mods: Super,   chars: "\x1b[1;3S"                   }
  - { key: F5,       mods: Super,   chars: "\x1b[15;3~"                  }
  - { key: F6,       mods: Super,   chars: "\x1b[17;3~"                  }
  - { key: F7,       mods: Super,   chars: "\x1b[18;3~"                  }
  - { key: F8,       mods: Super,   chars: "\x1b[19;3~"                  }
  - { key: F9,       mods: Super,   chars: "\x1b[20;3~"                  }
  - { key: F10,      mods: Super,   chars: "\x1b[21;3~"                  }
  - { key: F11,      mods: Super,   chars: "\x1b[23;3~"                  }
  - { key: F12,      mods: Super,   chars: "\x1b[24;3~"                  }
