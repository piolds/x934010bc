parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [[ "$IS_NIX_SHELL" == "1" ]]
then
    PROMPT='[nix-shell] %F{218}%1 %n%F{256}%1 @%F{218}%1 %m%F{256}%1 :%~%b %F{218}%1 $(parse_git_branch) %F{256}%1 $ '
else 
PROMPT='%F{218}%1 %n%F{256}%1 @%F{218}%1 %m%F{256}%1 :%~%b %F{218}%1 $(parse_git_branch) %F{256}%1 $ '
fi

PATH="/home/$USER/programs:${PATH}"

# binding CTRL-g to jump (formarks)
autoload -Uz jump
zle -N jump
bindkey '^g' jump

