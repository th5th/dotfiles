# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add home bin to path
export PATH="${HOME}/bin:${PATH}"
export EDITOR="vim"

# basic timesavers
cl() { cd "$1"; shift; ls "$@"; }
mkcl() { mkdir "$@" && cl "$1"; }
back() { cl "$OLDPWD" "$@"; }
mvcl() { mv "$@"; _dest=${!#}; if [ -d "$_dest" ]; then cl "$_dest"; else ls; fi; }
psgr() { ps ax | awk -vcommand="$1" 'NR == 1 || $5 ~ command'; }

if command -v markdown > /dev/null; then
    md() { markdown "$1" > "${1%.*}.html"; }
fi

# Control backlight brightness from bash to avoid fumbling for F keys
if command -v xbacklight > /dev/null; then
    alias blup="xbacklight -inc 10"
    alias bldown="xbacklight -dec 10"
fi

# Pacman aliases.
if command -v pacman > /dev/null; then
    alias pac="sudo pacman -S"     # install one or more packages
    alias pacu="sudo pacman -Syu"  # [u]pgrade all packages
    alias pacr="sudo pacman -Rs"   # [r]emove one or more packages
    alias paci="pacman -Qi"        # show [i]nformation about a package
    alias pacs="pacman -Ss"        # [s]earch for a package
    alias pacsi="pacman -Si"       # show [i]nformation about a package (from repos)
    alias paclo="pacman -Qdt"      # [l]ist [o]rphaned packages
    alias pacc="sudo pacman -Scc"  # un[c]ache non-installed packages
    alias paclf="pacman -Ql"       # [l]ist [f]iles installed by a package

    # '[r]emove [o]rphans' - recursively remove ALL orphaned packages
    alias pacro="pacman -Qtdq > /dev/null && sudo pacman -Rs \$(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"

    alias pacwhich="pacman -Qo"    # Query who owns the given file.

    # which packages [req]uire this package
    pacreq() { pacman -Qii "$@" | awk -F ": " '/Required By/ { print $2}'; }

    pacdiff()
    {
        if [[ -z $1 ]]; then
            echo "Missing operand. Provide a file to compare"
            return 1
        fi

        if [[ -e $1 ]] && [[ -e $1.pacnew ]]; then
            vimdiff $1 $1.pacnew
        else
            echo "No pacnew file found."
            return 1
        fi
    }
fi

alias ncst="sudo netctl switch-to"

alias githist="git log --oneline --graph --decorate"

# Undef annoying terminal key bindings
stty stop undef
stty start undef
