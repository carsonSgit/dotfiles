alias gs = git status
alias ga = git add .
alias gc = git commit
alias gco = git checkout
alias gl = git log --oneline --graph --decorate

alias ll = ls -la
alias la = ls -a

alias explore = explorer .

def path [] {
  $env.PATH | split row (char esep)
}

if (which fastfetch | is-not-empty) {
  fastfetch
}

def here [] {
  pwd | path expand
}

def today [] {
  date now | format date "%A, %B %d %Y"
}

$env.config.show_banner = false

# Theme system
const THEMES_DIR = "C:\\Users\\carso\\AppData\\Roaming\\nushell\\themes"
const THEME_FILE = "C:\\Users\\carso\\AppData\\Roaming\\nushell\\.current_theme"

# Available themes
def get-themes [] {
  [
    "circus"
    "cyberdream"
    "ocean"
    "onedark"
    "snow-dark"
    "teerb"
    "tomorrow-night"
    "two-firewatch"
  ]
}

# Load a theme by name (works at runtime using .nuon data files)
def load-theme [name: string] {
  let theme_path = ($THEMES_DIR | path join $"($name).nuon")
  if ($theme_path | path exists) {
    $env.config.color_config = (open $theme_path)
  } else {
    print $"(ansi red)Theme file not found: ($theme_path)(ansi reset)"
  }
}

# Interactive theme switcher (run `theme` for menu, or `theme <name>` / `theme <number>`)
def theme [selection?: string] {
  let themes = (get-themes)
  let current = if ($THEME_FILE | path exists) { open $THEME_FILE | str trim } else { "ocean" }

  # If a selection was provided, use it directly
  let choice = if ($selection != null) {
    $selection
  } else {
    # Show interactive menu
    print $"(ansi cyan)Available themes:(ansi reset)"
    print ""

    $themes | enumerate | each { |it|
      let marker = if $it.item == $current { $"(ansi green)*(ansi reset) " } else { "  " }
      print $"  ($marker)(ansi yellow)($it.index + 1)(ansi reset). ($it.item)"
    }

    print ""
    let count = ($themes | length)
    input $"(ansi cyan)Select theme \(1-($count)\) or name: (ansi reset)"
  }

  let selected = if ($choice | str trim | parse -r '^\d+$' | is-not-empty) {
    let idx = ($choice | into int) - 1
    if $idx >= 0 and $idx < ($themes | length) {
      $themes | get $idx
    } else {
      print $"(ansi red)Invalid selection(ansi reset)"
      return
    }
  } else {
    let name = ($choice | str trim)
    if ($name in $themes) {
      $name
    } else {
      print $"(ansi red)Theme '($name)' not found(ansi reset)"
      return
    }
  }

  $selected | save -f $THEME_FILE
  load-theme $selected
  print $"(ansi green)Theme changed to: ($selected)(ansi reset)"
}

# Load saved theme on startup (defaults to ocean)
let current_theme = if ($THEME_FILE | path exists) {
  open $THEME_FILE | str trim
} else {
  "ocean"
}
load-theme $current_theme
