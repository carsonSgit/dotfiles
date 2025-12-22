alias gs = git status
alias ga = git add .
alias gc = git commit
alias gco = git checkout
alias gl = git log --oneline --graph --decorate

alias ll = ls -la
alias la = ls -a

alias open = explorer .

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
